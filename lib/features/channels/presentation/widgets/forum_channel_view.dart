import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluxer_app/core/router/fluxer_router.dart';
import 'package:fluxer_app/core/router/route_names.dart';
import 'package:fluxer_app/core/talker.dart';
import 'package:fluxer_app/core/theme/fluxer_theme_extension.dart';
import 'package:fluxer_app/features/channels/domain/channel.dart';
import 'package:fluxer_app/features/channels/presentation/widgets/thread_ui.dart';
import 'package:fluxer_app/features/channels/providers/channel_providers.dart';
import 'package:fluxer_app/features/channels/providers/thread_providers.dart';
import 'package:fluxer_app/features/chat/providers/core/chat_providers.dart';
import 'package:fluxer_app/features/ui/ui.dart';
import 'package:fluxer_app/l10n/generated/fluxer_localizations.dart';
import 'package:fluxer_app/material_ui.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

/// Echowire: renders a forum channel (type 15) as a list of posts (threads)
/// instead of a message stream. Supports active/archived, tag filtering, and
/// creating a new post.
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

class _ForumChannelViewState extends ConsumerState<ForumChannelView> {
  late final Stream<List<Channel>> _threadsStream;
  bool _showArchived = false;
  final Set<String> _tagFilter = <String>{};
  String _searchQuery = '';
  _ForumSort _sort = _ForumSort.recent;

  List<ForumTag> get _availableTags =>
      widget.channel.availableTags ?? const <ForumTag>[];

  @override
  void initState() {
    super.initState();
    _threadsStream = ref
        .read(threadRepositoryProvider)
        .watchThreads(widget.channel.id);
    _refresh();
  }

  void _refresh() {
    // Populate/refresh the cache from the API (fire-and-forget); the list itself
    // watches the DB, so gateway-created posts also appear live.
    unawaited(
      ref
          .read(threadRepositoryProvider)
          .refreshThreads(widget.channel.id, guildId: widget.guildId),
    );
  }

  void _openPost(Channel post) {
    context.go(RoutePaths.guildChannel(post.guildId, post.id));
  }

  ForumTag? _tagById(String id) {
    for (final ForumTag t in _availableTags) {
      if (t.id == id) {
        return t;
      }
    }
    return null;
  }

  List<Channel> _visiblePosts(List<Channel> posts) {
    Iterable<Channel> filtered = posts.where(
      (Channel p) => p.isArchived == _showArchived,
    );
    if (_tagFilter.isNotEmpty) {
      filtered = filtered.where(
        (Channel p) =>
            (p.appliedTags ?? const <String>[]).any(_tagFilter.contains),
      );
    }
    if (_searchQuery.trim().isNotEmpty) {
      final String q = _searchQuery.trim().toLowerCase();
      filtered = filtered.where(
        (Channel p) => p.name.toLowerCase().contains(q),
      );
    }
    final List<Channel> result = filtered.toList();
    // Pinned posts first, then by the selected sort order.
    result.sort((Channel a, Channel b) {
      final int pin =
          ((b.threadPinned ?? false) ? 1 : 0) -
          ((a.threadPinned ?? false) ? 1 : 0);
      if (pin != 0) {
        return pin;
      }
      return switch (_sort) {
        _ForumSort.recent => b.id.compareTo(a.id),
        _ForumSort.name => a.name.toLowerCase().compareTo(b.name.toLowerCase()),
      };
    });
    return result;
  }

  Future<void> _onRefresh() => ref
      .read(threadRepositoryProvider)
      .refreshThreads(widget.channel.id, guildId: widget.guildId);

  Offset _anchorOf(BuildContext anchorContext) {
    final RenderBox? box = anchorContext.findRenderObject() as RenderBox?;
    return box == null
        ? Offset.zero
        : box.localToGlobal(box.size.bottomRight(Offset.zero));
  }

  Future<void> _openSortMenu(BuildContext anchorContext) {
    final FluxerLocalizations l10n = FluxerLocalizations.of(context);
    return FluxerActionMenu.show(
      anchorContext,
      position: _anchorOf(anchorContext),
      builder: (BuildContext menuContext, VoidCallback close) {
        Widget option(_ForumSort sort, String label) => FluxerMenuRadioItem(
          label: label,
          isSelected: _sort == sort,
          onPressed: () {
            close();
            setState(() => _sort = sort);
          },
        );
        return <Widget>[
          option(_ForumSort.recent, l10n.forumSortRecentActivity),
          option(_ForumSort.name, l10n.forumSortName),
        ];
      },
    );
  }

  Future<void> _manageTags() async {
    final FluxerLocalizations l10n = FluxerLocalizations.of(context);
    final List<_EditableTag> draft = <_EditableTag>[
      for (final ForumTag t in _availableTags)
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
    final _ForumPostDraft draft = _ForumPostDraft();
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
    _openPost(post);
  }

  String _postSubtitle(FluxerLocalizations l10n, Channel post) {
    return <String>[
      if (post.threadMessageCount != null)
        l10n.threadsMessageCount(post.threadMessageCount!),
      if (post.threadMemberCount != null)
        l10n.threadsMemberCount(post.threadMemberCount!),
      if (post.isArchived) l10n.threadsStatusArchived,
    ].join('  ·  ');
  }

  @override
  Widget build(BuildContext context) {
    final FluxerLocalizations l10n = FluxerLocalizations.of(context);
    final colors = context.colors;
    final layout = context.layout;
    final bool canManage = watchCanManageThreads(ref, widget.channel.id);
    final String? currentUserId = ref.watch(currentUserIdProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.fromLTRB(layout.s3, layout.s2, layout.s3, 0),
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
              Expanded(
                child: FluxerInput(
                  hint: l10n.forumSearchPosts,
                  prefixIcon: Icon(
                    PhosphorIconsBold.magnifyingGlass,
                    size: 18,
                    color: colors.textSecondary,
                  ),
                  textInputAction: TextInputAction.search,
                  onChanged: (String v) => setState(() => _searchQuery = v),
                ),
              ),
              SizedBox(width: layout.s1),
              Builder(
                builder: (BuildContext anchorContext) => FluxerButton.ghost(
                  icon: PhosphorIconsBold.arrowsDownUp,
                  isSquare: true,
                  semanticLabel: l10n.forumSortAndView,
                  onPressed: () => unawaited(_openSortMenu(anchorContext)),
                ),
              ),
              if (canManage)
                FluxerButton.ghost(
                  icon: PhosphorIconsBold.tag,
                  isSquare: true,
                  semanticLabel: l10n.forumManageTags,
                  onPressed: () => unawaited(_manageTags()),
                ),
            ],
          ),
        ),
        if (_availableTags.isNotEmpty)
          SizedBox(
            height: 40,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(
                horizontal: layout.s3,
                vertical: layout.s1,
              ),
              itemCount: _availableTags.length,
              separatorBuilder: (_, _) => SizedBox(width: layout.s2),
              itemBuilder: (BuildContext context, int index) {
                final ForumTag tag = _availableTags[index];
                final bool selected = _tagFilter.contains(tag.id);
                return Center(
                  child: ForumTagChip(
                    label: tag.name,
                    selected: selected,
                    onTap: () => setState(() {
                      if (selected) {
                        _tagFilter.remove(tag.id);
                      } else {
                        _tagFilter.add(tag.id);
                      }
                    }),
                  ),
                );
              },
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
                  final List<Channel> posts = _visiblePosts(
                    snapshot.data ?? <Channel>[],
                  );
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
                  return RefreshIndicator(
                    onRefresh: _onRefresh,
                    child: ListView.builder(
                      padding: EdgeInsets.symmetric(vertical: layout.s2),
                      itemCount: posts.length,
                      itemBuilder: (BuildContext context, int index) {
                        final Channel post = posts[index];
                        final List<String> tagNames = <String>[
                          for (final String id
                              in post.appliedTags ?? const <String>[])
                            if (_tagById(id) case final ForumTag t) t.name,
                        ];
                        return FluxerListRow(
                          leading: Icon(
                            post.threadPinned ?? false
                                ? PhosphorIconsFill.pushPin
                                : PhosphorIconsRegular.chatCircle,
                            size: 20,
                            color: colors.textSecondary,
                          ),
                          title: post.name,
                          subtitle: _postSubtitle(l10n, post),
                          tagsBelowTitle: <Widget>[
                            for (final String name in tagNames)
                              ForumTagChip(label: name),
                          ],
                          trailing: ThreadModMenuButton(
                            thread: post,
                            actions: threadModActionsFor(
                              thread: post,
                              canManage: canManage,
                              currentUserId: currentUserId,
                            ),
                          ),
                          onTap: () => _openPost(post),
                        );
                      },
                    ),
                  );
                },
          ),
        ),
      ],
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

enum _ForumSort { recent, name }

class _ForumPostDraft extends ChangeNotifier {
  String title = '';
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

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        FluxerInput(
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
