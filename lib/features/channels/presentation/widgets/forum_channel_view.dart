import 'dart:async';

import 'package:cached_network_image_ce/cached_network_image.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluxer_app/core/router/fluxer_router.dart';
import 'package:fluxer_app/core/router/route_names.dart';
import 'package:fluxer_app/core/talker.dart';
import 'package:fluxer_app/core/theme/fluxer_theme_extension.dart';
import 'package:fluxer_app/features/channels/data/read_state_utils.dart';
import 'package:fluxer_app/features/channels/domain/channel.dart';
import 'package:fluxer_app/features/channels/domain/forum_view.dart';
import 'package:fluxer_app/features/channels/presentation/widgets/thread_ui.dart';
import 'package:fluxer_app/features/channels/providers/channel_providers.dart';
import 'package:fluxer_app/features/channels/providers/read_state_repository_provider.dart';
import 'package:fluxer_app/features/channels/providers/thread_providers.dart';
import 'package:fluxer_app/features/channels/providers/unread_provider.dart';
import 'package:fluxer_app/features/chat/providers/core/chat_providers.dart';
import 'package:fluxer_app/features/ui/ui.dart';
import 'package:fluxer_app/l10n/generated/fluxer_localizations.dart';
import 'package:fluxer_app/material_ui.dart';
import 'package:fluxer_app/shared/providers/member_role_color.dart';
import 'package:fluxer_app/shared/utils/relative_time.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Echowire: renders a forum channel (type 15) as a list or gallery of posts
/// (threads) instead of a message stream. Supports active/archived, narrowing
/// tag filters, title search that seeds a new post, a per-user Sort & View
/// override, and the post menu.
class ForumChannelView extends ConsumerStatefulWidget {
  const ForumChannelView({
    required this.channel,
    required this.guildId,
    super.key,
  });

  final Channel channel;
  final String guildId;

  @override
  ConsumerState<ForumChannelView> createState() => _ForumChannelViewState();
}

/// The per-user Sort & View override for a forum, stored with
/// SharedPreferences under `echowire_forum_view_<forumId>` as `sort,layout`
/// wire values, where `-1` means "use the channel default".
class _ForumViewOverride {
  const _ForumViewOverride({this.sort, this.layout});

  final ForumSortOrder? sort;
  final ForumLayout? layout;

  static String keyFor(String forumId) => 'echowire_forum_view_$forumId';

  factory _ForumViewOverride.parse(String? raw) {
    final List<String> parts = (raw ?? '').split(',');
    int? read(int index) =>
        parts.length > index ? int.tryParse(parts[index]) : null;
    final int? sort = read(0);
    final int? layout = read(1);
    return _ForumViewOverride(
      sort: sort == null || sort < 0 ? null : ForumSortOrder.fromWire(sort),
      layout: layout == null || layout < 0
          ? null
          : ForumLayout.fromWire(layout),
    );
  }

  String encode() => '${sort?.wireValue ?? -1},${layout?.wireValue ?? -1}';
}

class _ForumChannelViewState extends ConsumerState<ForumChannelView> {
  late final Stream<List<Channel>> _threadsStream;
  bool _showArchived = false;
  final Set<String> _tagFilter = <String>{};
  final TextEditingController _search = TextEditingController();
  _ForumViewOverride _override = const _ForumViewOverride();
  String? _lastAckedActivity;

  Channel get _forum =>
      ref.watch(channelByIdProvider(widget.channel.id)).value ?? widget.channel;

  @override
  void initState() {
    super.initState();
    _threadsStream = ref
        .read(threadRepositoryProvider)
        .watchThreads(widget.channel.id);
    _refresh();
    unawaited(
      ref.read(threadRepositoryProvider).loadForumExtras(widget.channel.id),
    );
    unawaited(_loadOverride());
  }

  @override
  void dispose() {
    _search.dispose();
    super.dispose();
  }

  Future<void> _loadOverride() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final _ForumViewOverride value = _ForumViewOverride.parse(
      prefs.getString(_ForumViewOverride.keyFor(widget.channel.id)),
    );
    if (mounted) {
      setState(() => _override = value);
    }
  }

  Future<void> _saveOverride(_ForumViewOverride value) async {
    setState(() => _override = value);
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String key = _ForumViewOverride.keyFor(widget.channel.id);
    if (value.sort == null && value.layout == null) {
      await prefs.remove(key);
    } else {
      await prefs.setString(key, value.encode());
    }
  }

  void _refresh() {
    // Populate/refresh the cache from the API (fire-and-forget); the list itself
    // watches the DB, so gateway-created posts also appear live.
    unawaited(
      ref
          .read(threadRepositoryProvider)
          .refreshThreads(widget.channel.id, guildId: widget.guildId)
          .catchError((Object e, StackTrace st) {
            talker.error('Could not refresh forum posts', e, st);
          }),
    );
  }

  /// Marks the forum as visited up to its newest post activity, which is what
  /// the sidebar "N New" count compares against.
  void _ackForum(List<Channel> posts) {
    String? newest;
    for (final Channel p in posts) {
      if (p.isArchived) {
        continue;
      }
      final String activity = p.activityId;
      if (newest == null || compareSnowflakeStrings(activity, newest) > 0) {
        newest = activity;
      }
    }
    if (newest == null || newest == _lastAckedActivity) {
      return;
    }
    _lastAckedActivity = newest;
    final String ackId = newest;
    unawaited(
      ref
          .read(readStateRepositoryProvider)
          .ackForumActivity(widget.channel.id, ackId)
          .catchError((Object e, StackTrace st) {
            talker.error('Could not ack forum ${widget.channel.id}', e, st);
          }),
    );
  }

  void _openPost(Channel post) {
    context.go(RoutePaths.guildChannel(post.guildId, post.id));
  }

  ForumSortOrder _effectiveSort(Channel forum) =>
      _override.sort ?? ForumSortOrder.fromWire(forum.defaultSortOrder);

  ForumLayout _effectiveLayout() =>
      _override.layout ??
      ForumLayout.fromWire(
        ref.watch(forumExtrasProvider(widget.channel.id))?.defaultLayout,
      );

  List<Channel> _visiblePosts(List<Channel> posts, ForumSortOrder sort) {
    Iterable<Channel> filtered = posts.where(
      (Channel p) => p.isArchived == _showArchived,
    );
    if (_tagFilter.isNotEmpty) {
      // Narrowing: a post must carry every selected tag.
      filtered = filtered.where((Channel p) {
        final List<String> applied = p.appliedTags ?? const <String>[];
        return _tagFilter.every(applied.contains);
      });
    }
    final String q = _search.text.trim().toLowerCase();
    if (q.isNotEmpty) {
      filtered = filtered.where(
        (Channel p) => p.name.toLowerCase().contains(q),
      );
    }
    final List<Channel> result = filtered.toList();
    // The pinned post first, then by the selected sort order.
    result.sort((Channel a, Channel b) {
      final int pin =
          ((b.threadPinned ?? false) ? 1 : 0) -
          ((a.threadPinned ?? false) ? 1 : 0);
      if (pin != 0) {
        return pin;
      }
      return switch (sort) {
        ForumSortOrder.latestActivity => compareSnowflakeStrings(
          b.activityId,
          a.activityId,
        ),
        ForumSortOrder.creationDate => compareSnowflakeStrings(b.id, a.id),
      };
    });
    return result;
  }

  Future<void> _onRefresh() => ref
      .read(threadRepositoryProvider)
      .refreshThreads(widget.channel.id, guildId: widget.guildId);

  Future<void> _openSortAndView() {
    final FluxerLocalizations l10n = FluxerLocalizations.of(context);
    final Channel forum =
        ref.read(channelByIdProvider(widget.channel.id)).value ??
        widget.channel;
    final ForumSortOrder sort =
        _override.sort ?? ForumSortOrder.fromWire(forum.defaultSortOrder);
    final ForumLayout layout =
        _override.layout ??
        ForumLayout.fromWire(
          ref.read(forumExtrasProvider(widget.channel.id))?.defaultLayout,
        );
    return FluxerBottomSheet.show<void>(
      context,
      title: l10n.forumSortAndView,
      variant: FluxerBottomSheetVariant.menu,
      builder: (BuildContext sheetContext, VoidCallback close) {
        Widget option({
          required String label,
          required bool selected,
          required _ForumViewOverride next,
        }) => FluxerBottomSheetMenuItem(
          label: label,
          isSelected: selected,
          icon: selected
              ? PhosphorIconsBold.radioButton
              : PhosphorIconsBold.circle,
          onTap: () {
            close();
            unawaited(_saveOverride(next));
          },
        );
        return FluxerBottomSheetContent(
          child: FluxerBottomSheetGroupColumn(
            children: <Widget>[
              _SheetSectionLabel(l10n.forumSortBy),
              FluxerMenuGroup(
                children: <Widget>[
                  option(
                    label: l10n.forumSortRecentActivity,
                    selected: sort == ForumSortOrder.latestActivity,
                    next: _ForumViewOverride(
                      sort: ForumSortOrder.latestActivity,
                      layout: _override.layout,
                    ),
                  ),
                  option(
                    label: l10n.forumSortDatePosted,
                    selected: sort == ForumSortOrder.creationDate,
                    next: _ForumViewOverride(
                      sort: ForumSortOrder.creationDate,
                      layout: _override.layout,
                    ),
                  ),
                ],
              ),
              _SheetSectionLabel(l10n.forumViewAs),
              FluxerMenuGroup(
                children: <Widget>[
                  option(
                    label: l10n.forumLayoutList,
                    selected: layout == ForumLayout.list,
                    next: _ForumViewOverride(
                      sort: _override.sort,
                      layout: ForumLayout.list,
                    ),
                  ),
                  option(
                    label: l10n.forumLayoutGallery,
                    selected: layout == ForumLayout.gallery,
                    next: _ForumViewOverride(
                      sort: _override.sort,
                      layout: ForumLayout.gallery,
                    ),
                  ),
                ],
              ),
              FluxerMenuGroup(
                children: <Widget>[
                  FluxerBottomSheetMenuItem(
                    label: l10n.forumResetViewToDefault,
                    icon: PhosphorIconsBold.arrowCounterClockwise,
                    enabled: _override.sort != null || _override.layout != null,
                    onTap: () {
                      close();
                      unawaited(_saveOverride(const _ForumViewOverride()));
                    },
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _openAllTags(List<ForumTag> tags) {
    final FluxerLocalizations l10n = FluxerLocalizations.of(context);
    return FluxerBottomSheet.show<void>(
      context,
      title: l10n.forumAllTags,
      variant: FluxerBottomSheetVariant.menu,
      builder: (BuildContext sheetContext, VoidCallback close) =>
          FluxerBottomSheetContent(
            child: StatefulBuilder(
              builder: (BuildContext _, StateSetter setSheetState) =>
                  FluxerMenuGroup(
                    children: <Widget>[
                      for (final ForumTag tag in tags)
                        FluxerBottomSheetMenuItem(
                          label: tag.name,
                          isSelected: _tagFilter.contains(tag.id),
                          icon: _tagFilter.contains(tag.id)
                              ? PhosphorIconsFill.checkSquare
                              : PhosphorIconsBold.square,
                          onTap: () {
                            setState(() {
                              if (!_tagFilter.remove(tag.id)) {
                                _tagFilter.add(tag.id);
                              }
                            });
                            setSheetState(() {});
                          },
                        ),
                    ],
                  ),
            ),
          ),
    );
  }

  Future<void> _manageTags(List<ForumTag> availableTags) async {
    final FluxerLocalizations l10n = FluxerLocalizations.of(context);
    final List<_EditableTag> draft = <_EditableTag>[
      for (final ForumTag t in availableTags)
        _EditableTag(id: t.id, name: t.name, emojiName: t.emojiName),
    ];
    final bool? save = await FluxerModal.show<bool>(
      context,
      title: l10n.forumManageTags,
      builder: (BuildContext dialogContext, VoidCallback close) =>
          _ManageForumTagsBody(tags: draft),
      actionsBuilder: (pop) => <Widget>[
        FluxerButton.primary(onPressed: () => pop(true), label: l10n.save),
        const SizedBox(height: 8),
        FluxerButton.secondary(onPressed: pop, label: l10n.cancel),
      ],
    );
    if (save != true) {
      return;
    }
    try {
      await ref
          .read(channelRepositoryProvider)
          .updateForumTags(
            forumId: widget.channel.id,
            guildId: widget.guildId,
            tags: <Map<String, Object?>>[
              for (final _EditableTag t in draft) t.toJson(),
            ],
          );
      if (!mounted) {
        return;
      }
      showThreadToast(
        ref,
        l10n.forumTagsUpdated,
        variant: FluxerToastVariant.success,
      );
    } on Exception catch (e, st) {
      talker.error('Could not update forum tags', e, st);
      if (!mounted) {
        return;
      }
      showThreadToast(ref, l10n.forumTagsUpdateFailed);
    }
  }

  Future<void> _createPost() async {
    final FluxerLocalizations l10n = FluxerLocalizations.of(context);
    final _ForumPostDraft draft = _ForumPostDraft(
      initialTitle: _search.text.trim(),
    );
    final bool canManage = readCanManageThreads(ref, widget.channel.id);
    final bool? submit = await FluxerModal.show<bool>(
      context,
      title: l10n.forumNewPostTitle,
      builder: (BuildContext dialogContext, VoidCallback close) =>
          _NewForumPostBody(
            fallbackChannel: widget.channel,
            draft: draft,
            canManage: canManage,
          ),
      actionsBuilder: (pop) => <Widget>[
        Consumer(
          builder: (BuildContext consumerContext, WidgetRef consumerRef, _) {
            final Channel forum =
                consumerRef
                    .watch(channelByIdProvider(widget.channel.id))
                    .value ??
                widget.channel;
            return ListenableBuilder(
              listenable: draft,
              builder: (BuildContext _, Widget? _) => FluxerButton.primary(
                onPressed: draft.isValid(forum) ? () => pop(true) : null,
                label: l10n.forumCreatePost,
              ),
            );
          },
        ),
        const SizedBox(height: 8),
        FluxerButton.secondary(onPressed: pop, label: l10n.cancel),
      ],
    );
    if (submit != true || draft.title.trim().isEmpty) {
      return;
    }
    final Channel post;
    try {
      post = await ref
          .read(threadRepositoryProvider)
          .createThread(
            parentChannelId: widget.channel.id,
            name: draft.title.trim(),
            appliedTags: draft.tagIds.isEmpty ? null : draft.tagIds.toList(),
          );
    } on Exception catch (e, st) {
      talker.error('Could not create forum post', e, st);
      if (!mounted) {
        return;
      }
      showThreadToast(ref, l10n.forumCreatePostFailed);
      return;
    }
    final String body = draft.body.trim();
    if (body.isNotEmpty) {
      try {
        await ref
            .read(messageRepositoryProvider)
            .sendMessage(channelId: post.id, content: body);
      } on Exception catch (e, st) {
        talker.error('Forum post created but first message failed', e, st);
        if (mounted) {
          showThreadToast(ref, l10n.forumPostMessageFailed);
        }
      }
    }
    if (!mounted) {
      return;
    }
    _search.clear();
    _openPost(post);
  }

  @override
  Widget build(BuildContext context) {
    final FluxerLocalizations l10n = FluxerLocalizations.of(context);
    final colors = context.colors;
    final layout = context.layout;
    final Channel forum = _forum;
    final List<ForumTag> availableTags =
        forum.availableTags ?? const <ForumTag>[];
    final bool canManage = watchCanManageThreads(ref, widget.channel.id);
    final String? currentUserId = ref.watch(currentUserIdProvider);
    final ForumSortOrder sort = _effectiveSort(forum);
    final ForumLayout viewLayout = _effectiveLayout();
    // Show up to this many tag chips inline; the rest live behind "All".
    const int inlineTagLimit = 6;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.fromLTRB(layout.s3, layout.s2, layout.s3, 0),
          child: Row(
            children: <Widget>[
              Expanded(
                child: FluxerInput(
                  controller: _search,
                  hint: l10n.forumSearchOrCreatePost,
                  prefixIcon: Icon(
                    PhosphorIconsBold.magnifyingGlass,
                    size: 18,
                    color: colors.textSecondary,
                  ),
                  textInputAction: TextInputAction.search,
                  onChanged: (String _) => setState(() {}),
                ),
              ),
              SizedBox(width: layout.s2),
              FluxerButton.primary(
                onPressed: _createPost,
                icon: PhosphorIconsBold.plus,
                label: l10n.forumNewPost,
                size: FluxerButtonSize.compact,
                fitContent: true,
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(
            layout.s3,
            layout.s2,
            layout.s3,
            layout.s1,
          ),
          child: Row(
            children: <Widget>[
              FluxerSegmentedTabs(
                tabs: <FluxerTab>[
                  FluxerTab(label: l10n.threadsFilterActive),
                  FluxerTab(label: l10n.threadsFilterArchived),
                ],
                selectedIndex: _showArchived ? 1 : 0,
                onChanged: (int index) {
                  setState(() => _showArchived = index == 1);
                  _refresh();
                },
              ),
              const Spacer(),
              FluxerButton.ghost(
                icon: PhosphorIconsBold.arrowsDownUp,
                label: l10n.forumSortAndView,
                size: FluxerButtonSize.compact,
                fitContent: true,
                onPressed: () => unawaited(_openSortAndView()),
              ),
              if (canManage)
                FluxerButton.ghost(
                  icon: PhosphorIconsBold.tag,
                  isSquare: true,
                  size: FluxerButtonSize.compact,
                  semanticLabel: l10n.forumManageTags,
                  onPressed: () => unawaited(_manageTags(availableTags)),
                ),
            ],
          ),
        ),
        if (availableTags.isNotEmpty)
          SizedBox(
            height: 40,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(
                horizontal: layout.s3,
                vertical: layout.s1,
              ),
              children: <Widget>[
                for (final ForumTag tag in availableTags.take(inlineTagLimit))
                  Padding(
                    padding: EdgeInsets.only(right: layout.s2),
                    child: Center(
                      child: ForumTagChip(
                        label: tag.name,
                        selected: _tagFilter.contains(tag.id),
                        onTap: () => setState(() {
                          if (!_tagFilter.remove(tag.id)) {
                            _tagFilter.add(tag.id);
                          }
                        }),
                      ),
                    ),
                  ),
                Center(
                  child: ForumTagChip(
                    label: _tagFilter.isEmpty
                        ? l10n.forumAllTags
                        : l10n.forumTagsSelectedCount(_tagFilter.length),
                    selected: availableTags
                        .skip(inlineTagLimit)
                        .any((ForumTag t) => _tagFilter.contains(t.id)),
                    onTap: () => unawaited(_openAllTags(availableTags)),
                  ),
                ),
              ],
            ),
          ),
        Expanded(
          child: StreamBuilder<List<Channel>>(
            stream: _threadsStream,
            builder:
                (BuildContext context, AsyncSnapshot<List<Channel>> snapshot) {
                  if (snapshot.hasError) {
                    return ThreadListMessage(text: l10n.forumLoadFailed);
                  }
                  final List<Channel> all = snapshot.data ?? <Channel>[];
                  if (snapshot.hasData) {
                    WidgetsBinding.instance.addPostFrameCallback(
                      (_) => _ackForum(all),
                    );
                  }
                  final List<Channel> posts = _visiblePosts(all, sort);
                  if (posts.isEmpty) {
                    return RefreshIndicator(
                      onRefresh: _onRefresh,
                      child: ListView(
                        children: <Widget>[
                          SizedBox(height: layout.s24),
                          ThreadListMessage(
                            text: _showArchived
                                ? l10n.forumNoArchivedPosts
                                : l10n.forumNoPosts,
                          ),
                        ],
                      ),
                    );
                  }
                  List<ThreadModAction> actionsFor(Channel post) =>
                      threadModActionsFor(
                        thread: post,
                        canManage: canManage,
                        currentUserId: currentUserId,
                      );
                  if (viewLayout == ForumLayout.gallery) {
                    return RefreshIndicator(
                      onRefresh: _onRefresh,
                      child: GridView.builder(
                        padding: EdgeInsets.all(layout.s3),
                        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 220,
                          mainAxisSpacing: layout.s3,
                          crossAxisSpacing: layout.s3,
                          childAspectRatio: 0.78,
                        ),
                        itemCount: posts.length,
                        itemBuilder: (BuildContext context, int index) =>
                            _ForumPostCard(
                              post: posts[index],
                              guildId: widget.guildId,
                              availableTags: availableTags,
                              actions: actionsFor(posts[index]),
                              onTap: () => _openPost(posts[index]),
                            ),
                      ),
                    );
                  }
                  return RefreshIndicator(
                    onRefresh: _onRefresh,
                    child: ListView.builder(
                      padding: EdgeInsets.symmetric(vertical: layout.s2),
                      itemCount: posts.length,
                      itemBuilder: (BuildContext context, int index) =>
                          _ForumPostRow(
                            post: posts[index],
                            guildId: widget.guildId,
                            availableTags: availableTags,
                            actions: actionsFor(posts[index]),
                            onTap: () => _openPost(posts[index]),
                          ),
                    ),
                  );
                },
          ),
        ),
      ],
    );
  }
}

/// Resolved display data shared by the list row and the gallery card.
class _PostDisplay {
  _PostDisplay(WidgetRef ref, Channel post, List<ForumTag> availableTags)
    : preview = ref.watch(threadStarterPreviewsProvider)[post.id],
      tagNames = <String>[
        for (final String id in post.appliedTags ?? const <String>[])
          for (final ForumTag t in availableTags)
            if (t.id == id) t.name,
      ],
      isUnread =
          ref.watch(channelUnreadProvider(post.id)).value?.hasUnread ?? false;

  final ThreadStarterPreview? preview;
  final List<String> tagNames;
  final bool isUnread;

  static String lastActivity(FluxerLocalizations l10n, Channel post) {
    final int ms = snowflakeTimestampMs(post.activityId);
    if (ms <= 0) {
      return '';
    }
    return relativeTime(DateTime.fromMillisecondsSinceEpoch(ms), l10n);
  }
}

/// One forum post in list layout: tags, title, author-prefixed preview, reply
/// count and last activity, with the starter image on the right.
class _ForumPostRow extends ConsumerWidget {
  const _ForumPostRow({
    required this.post,
    required this.guildId,
    required this.availableTags,
    required this.actions,
    required this.onTap,
  });

  final Channel post;
  final String guildId;
  final List<ForumTag> availableTags;
  final List<ThreadModAction> actions;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final FluxerLocalizations l10n = FluxerLocalizations.of(context);
    final colors = context.colors;
    final textStyles = context.textStyles;
    final layout = context.layout;
    final _PostDisplay display = _PostDisplay(ref, post, availableTags);
    final ThreadStarterPreview? preview = display.preview;
    final String? authorId = preview?.authorId;
    final Color? authorColor = authorId == null
        ? null
        : ref.watch(memberRoleColorProvider((authorId, guildId)));
    final String? imageUrl = preview?.attachmentIsImage ?? false
        ? preview!.attachmentUrl
        : null;

    return FluxerTappable(
      onTap: onTap,
      onLongPress: actions.isEmpty
          ? null
          : () => unawaited(
              showThreadActionsMenu(
                context,
                ref,
                thread: post,
                actions: actions,
              ),
            ),
      semanticLabel: post.name,
      builder: (BuildContext _, Set<WidgetState> _) => Container(
        margin: EdgeInsets.symmetric(
          horizontal: layout.s3,
          vertical: layout.s1,
        ),
        padding: EdgeInsets.all(layout.s3),
        decoration: BoxDecoration(
          color: colors.backgroundSecondary,
          borderRadius: layout.radiusLg,
          border: Border.all(color: colors.borderColor),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  if (display.tagNames.isNotEmpty) ...<Widget>[
                    Wrap(
                      spacing: layout.s1,
                      runSpacing: layout.s1,
                      children: <Widget>[
                        for (final String name in display.tagNames)
                          ForumTagChip(label: name),
                      ],
                    ),
                    SizedBox(height: layout.s1),
                  ],
                  Row(
                    children: <Widget>[
                      if (post.threadPinned ?? false) ...<Widget>[
                        Icon(
                          PhosphorIconsFill.pushPin,
                          size: 14,
                          color: colors.textSecondary,
                        ),
                        SizedBox(width: layout.s1),
                      ],
                      Expanded(
                        child: Text(
                          post.name,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: textStyles.bodyMedium.copyWith(
                            color: display.isUnread
                                ? colors.textPrimary
                                : colors.textSecondary,
                            fontWeight: display.isUnread
                                ? FontWeight.w700
                                : FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  if (preview != null && preview.content.trim().isNotEmpty)
                    Padding(
                      padding: EdgeInsets.only(top: layout.s1),
                      child: Text.rich(
                        TextSpan(
                          children: <InlineSpan>[
                            if (preview.authorName != null)
                              TextSpan(
                                text: '${preview.authorName}: ',
                                style: TextStyle(
                                  color: authorColor ?? colors.textPrimary,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            TextSpan(text: preview.content.trim()),
                          ],
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: textStyles.bodySmall.copyWith(
                          color: colors.textSecondary,
                        ),
                      ),
                    ),
                  SizedBox(height: layout.s2),
                  _PostFooter(post: post, l10n: l10n),
                ],
              ),
            ),
            if (imageUrl != null) ...<Widget>[
              SizedBox(width: layout.s3),
              ClipRRect(
                borderRadius: layout.radiusMd,
                child: CachedNetworkImage(
                  imageUrl: imageUrl,
                  width: 64,
                  height: 64,
                  fit: BoxFit.cover,
                ),
              ),
            ],
            ThreadModMenuButton(thread: post, actions: actions),
          ],
        ),
      ),
    );
  }
}

/// Reply count and relative last activity.
class _PostFooter extends StatelessWidget {
  const _PostFooter({required this.post, required this.l10n});

  final Channel post;
  final FluxerLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final TextStyle style = context.textStyles.label.copyWith(
      color: colors.textTertiaryMuted,
    );
    final String activity = _PostDisplay.lastActivity(l10n, post);
    return Row(
      children: <Widget>[
        Icon(
          PhosphorIconsFill.chatCircle,
          size: 14,
          color: colors.textSecondary,
        ),
        const SizedBox(width: 4),
        Text('${post.threadMessageCount ?? 0}', style: style),
        if (activity.isNotEmpty) ...<Widget>[
          Text('  ·  ', style: style),
          Flexible(
            child: Text(
              activity,
              style: style,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
        if (post.isLocked) ...<Widget>[
          const SizedBox(width: 6),
          Icon(PhosphorIconsBold.lock, size: 12, color: colors.textSecondary),
        ],
      ],
    );
  }
}

/// One forum post in gallery layout: the starter image (or a placeholder)
/// above the title, tags and reply count.
class _ForumPostCard extends ConsumerWidget {
  const _ForumPostCard({
    required this.post,
    required this.guildId,
    required this.availableTags,
    required this.actions,
    required this.onTap,
  });

  final Channel post;
  final String guildId;
  final List<ForumTag> availableTags;
  final List<ThreadModAction> actions;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final FluxerLocalizations l10n = FluxerLocalizations.of(context);
    final colors = context.colors;
    final textStyles = context.textStyles;
    final layout = context.layout;
    final _PostDisplay display = _PostDisplay(ref, post, availableTags);
    final ThreadStarterPreview? preview = display.preview;
    final String? imageUrl = preview?.attachmentIsImage ?? false
        ? preview!.attachmentUrl
        : null;

    return FluxerTappable(
      onTap: onTap,
      onLongPress: actions.isEmpty
          ? null
          : () => unawaited(
              showThreadActionsMenu(
                context,
                ref,
                thread: post,
                actions: actions,
              ),
            ),
      semanticLabel: post.name,
      builder: (BuildContext _, Set<WidgetState> _) => DecoratedBox(
        decoration: BoxDecoration(
          color: colors.backgroundSecondary,
          borderRadius: layout.radiusLg,
          border: Border.all(color: colors.borderColor),
        ),
        child: ClipRRect(
          borderRadius: layout.radiusLg,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(
                child: imageUrl != null
                    ? CachedNetworkImage(imageUrl: imageUrl, fit: BoxFit.cover)
                    : ColoredBox(
                        color: colors.backgroundTertiary,
                        child: Icon(
                          PhosphorIconsFill.chatsCircle,
                          size: 32,
                          color: colors.textTertiaryMuted,
                        ),
                      ),
              ),
              Padding(
                padding: EdgeInsets.all(layout.s2),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      post.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: textStyles.bodySmall.copyWith(
                        color: display.isUnread
                            ? colors.textPrimary
                            : colors.textSecondary,
                        fontWeight: display.isUnread
                            ? FontWeight.w700
                            : FontWeight.w600,
                      ),
                    ),
                    if (display.tagNames.isNotEmpty) ...<Widget>[
                      SizedBox(height: layout.s1),
                      ForumTagChip(label: display.tagNames.first),
                    ],
                    SizedBox(height: layout.s1),
                    _PostFooter(post: post, l10n: l10n),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// A small caption above a group of options in a bottom sheet.
class _SheetSectionLabel extends StatelessWidget {
  const _SheetSectionLabel(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(context.layout.s1, context.layout.s2, 0, 0),
      child: Text(
        text,
        style: context.textStyles.label.copyWith(
          color: context.colors.textSecondary,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class _EditableTag {
  _EditableTag({required this.id, required this.name, this.emojiName});

  final String? id;
  final String name;
  final String? emojiName;

  Map<String, Object?> toJson() => <String, Object?>{
    'name': name,
    if (id != null) 'id': id,
    if (emojiName != null) 'emoji_name': emojiName,
  };
}

class _ManageForumTagsBody extends StatefulWidget {
  const _ManageForumTagsBody({required this.tags});

  /// Edited in place; the caller reads it back when the modal saves.
  final List<_EditableTag> tags;

  @override
  State<_ManageForumTagsBody> createState() => _ManageForumTagsBodyState();
}

class _ManageForumTagsBodyState extends State<_ManageForumTagsBody> {
  final TextEditingController _newTag = TextEditingController();

  @override
  void dispose() {
    _newTag.dispose();
    super.dispose();
  }

  void _add() {
    final String name = _newTag.text.trim();
    if (name.isEmpty) {
      return;
    }
    setState(() {
      widget.tags.add(_EditableTag(id: null, name: name));
      _newTag.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    final FluxerLocalizations l10n = FluxerLocalizations.of(context);
    final layout = context.layout;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        if (widget.tags.isEmpty)
          ThreadListMessage(text: l10n.forumNoTags)
        else
          Wrap(
            spacing: layout.s2,
            runSpacing: layout.s2,
            children: <Widget>[
              for (int i = 0; i < widget.tags.length; i++)
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    ForumTagChip(label: widget.tags[i].name),
                    FluxerButton.ghost(
                      icon: PhosphorIconsBold.x,
                      isSquare: true,
                      size: FluxerButtonSize.superCompact,
                      semanticLabel: l10n.forumRemoveTag,
                      onPressed: () => setState(() => widget.tags.removeAt(i)),
                    ),
                  ],
                ),
            ],
          ),
        SizedBox(height: layout.s4),
        FluxerInput(
          controller: _newTag,
          label: l10n.forumNewTagLabel,
          hint: l10n.forumNewTagHint,
          maxLength: 20,
          textInputAction: TextInputAction.done,
          onSubmitted: (_) => _add(),
          trailing: FluxerButton.secondary(
            icon: PhosphorIconsBold.plus,
            isSquare: true,
            size: FluxerButtonSize.small,
            semanticLabel: l10n.forumAddTag,
            onPressed: _add,
          ),
        ),
      ],
    );
  }
}

class _ForumPostDraft extends ChangeNotifier {
  _ForumPostDraft({String initialTitle = ''})
    : title = initialTitle,
      titleController = TextEditingController(text: initialTitle);

  String title;

  /// Seeds the title field from the forum search box.
  final TextEditingController titleController;

  String body = '';
  final Set<String> tagIds = <String>{};

  void setTitle(String value) {
    title = value;
    notifyListeners();
  }

  void toggleTag(String id) {
    if (!tagIds.remove(id)) {
      tagIds.add(id);
    }
    notifyListeners();
  }

  /// A post needs a title, and a tag when [forum] requires one.
  bool isValid(Channel forum) {
    final bool requiresTag = forum.forumRequireTag ?? false;
    return title.trim().isNotEmpty && (!requiresTag || tagIds.isNotEmpty);
  }
}

class _NewForumPostBody extends ConsumerWidget {
  const _NewForumPostBody({
    required this.fallbackChannel,
    required this.draft,
    required this.canManage,
  });

  final Channel fallbackChannel;
  final _ForumPostDraft draft;
  final bool canManage;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final FluxerLocalizations l10n = FluxerLocalizations.of(context);
    final colors = context.colors;
    final textStyles = context.textStyles;
    final layout = context.layout;
    // Watch the forum itself so tags added elsewhere show up while composing.
    final Channel forum =
        ref.watch(channelByIdProvider(fallbackChannel.id)).value ??
        fallbackChannel;
    final List<ForumTag> tags = forum.availableTags ?? const <ForumTag>[];
    final bool requiresTag = forum.forumRequireTag ?? false;

    final TextStyle hintStyle = textStyles.bodySmall.copyWith(
      color: colors.textSecondary,
    );

    final String guidelines = (forum.topic ?? '').trim();

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        if (guidelines.isNotEmpty) ...<Widget>[
          Container(
            padding: EdgeInsets.all(layout.s3),
            decoration: BoxDecoration(
              color: colors.backgroundTertiary,
              borderRadius: layout.radiusMd,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  l10n.forumPostGuidelinesLabel,
                  style: textStyles.label.copyWith(
                    color: colors.textPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: layout.s1),
                Text(guidelines, style: hintStyle),
              ],
            ),
          ),
          SizedBox(height: layout.s4),
        ],
        FluxerInput(
          controller: draft.titleController,
          label: l10n.forumPostTitleLabel,
          hint: l10n.forumPostTitleHint,
          maxLength: 100,
          autofocus: true,
          textInputAction: TextInputAction.next,
          onChanged: draft.setTitle,
        ),
        SizedBox(height: layout.s4),
        FluxerInput.multiline(
          label: l10n.forumPostMessageLabel,
          hint: l10n.forumPostMessageHint,
          onChanged: (String value) => draft.body = value,
        ),
        if (tags.isNotEmpty) ...<Widget>[
          SizedBox(height: layout.s4),
          Text(
            requiresTag
                ? l10n.forumPostTagsRequiredLabel
                : l10n.forumPostTagsLabel,
            style: textStyles.label.copyWith(
              color: colors.textPrimary,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: layout.s2),
          ListenableBuilder(
            listenable: draft,
            builder: (BuildContext _, Widget? _) => Wrap(
              spacing: layout.s2,
              runSpacing: layout.s2,
              children: <Widget>[
                for (final ForumTag tag in tags)
                  ForumTagChip(
                    label: tag.name,
                    selected: draft.tagIds.contains(tag.id),
                    onTap: () => draft.toggleTag(tag.id),
                  ),
              ],
            ),
          ),
        ] else if (requiresTag) ...<Widget>[
          SizedBox(height: layout.s4),
          Text(l10n.forumPostTagsRequiredNoneHint, style: hintStyle),
        ] else if (canManage) ...<Widget>[
          SizedBox(height: layout.s4),
          Text(l10n.forumPostNoTagsHint, style: hintStyle),
        ],
      ],
    );
  }
}
