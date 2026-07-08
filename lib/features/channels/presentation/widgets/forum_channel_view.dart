import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluxer_app/core/router/route_names.dart';
import 'package:fluxer_app/features/channels/data/thread_repository.dart';
import 'package:fluxer_app/features/channels/domain/channel.dart';
import 'package:fluxer_app/features/channels/providers/thread_providers.dart';
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
      filtered = filtered.where((Channel p) => p.name.toLowerCase().contains(q));
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
        _ForumSort.name =>
          a.name.toLowerCase().compareTo(b.name.toLowerCase()),
      };
    });
    return result;
  }

  Future<void> _onRefresh() => ref
      .read(threadRepositoryProvider)
      .refreshThreads(widget.channel.id, guildId: widget.guildId);

  Future<void> _moderatePost(Channel post, _PostModAction action) async {
    final ThreadRepository repo = ref.read(threadRepositoryProvider);
    try {
      switch (action) {
        case _PostModAction.togglePin:
          await repo.updateThread(post.id, pinned: !(post.threadPinned ?? false));
        case _PostModAction.toggleArchive:
          await repo.updateThread(post.id, archived: !post.isArchived);
        case _PostModAction.toggleLock:
          await repo.updateThread(post.id, locked: !post.isLocked);
        case _PostModAction.delete:
          await repo.deleteThread(post.id);
      }
    } on Exception catch (e) {
      if (!mounted) {
        return;
      }
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Action failed: $e')));
    }
  }

  Future<void> _createPost() async {
    final _ForumPostDraft? draft = await showDialog<_ForumPostDraft>(
      context: context,
      builder: (BuildContext context) =>
          _NewForumPostDialog(availableTags: _availableTags),
    );
    if (draft == null || draft.title.trim().isEmpty) {
      return;
    }
    try {
      final Channel post = await ref
          .read(threadRepositoryProvider)
          .createThread(
            parentChannelId: widget.channel.id,
            name: draft.title.trim(),
            appliedTags: draft.tagIds.isEmpty ? null : draft.tagIds.toList(),
          );
      _openPost(post);
    } on Exception catch (e) {
      if (!mounted) {
        return;
      }
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Could not create post: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(12, 8, 12, 4),
          child: Row(
            children: <Widget>[
              Expanded(
                child: SegmentedButton<bool>(
                  segments: const <ButtonSegment<bool>>[
                    ButtonSegment<bool>(value: false, label: Text('Active')),
                    ButtonSegment<bool>(value: true, label: Text('Archived')),
                  ],
                  selected: <bool>{_showArchived},
                  onSelectionChanged: (Set<bool> s) {
                    setState(() => _showArchived = s.first);
                    _refresh();
                  },
                ),
              ),
              const SizedBox(width: 8),
              FilledButton.icon(
                onPressed: _createPost,
                icon: const Icon(PhosphorIconsBold.plus, size: 16),
                label: const Text('Post'),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(12, 0, 12, 4),
          child: Row(
            children: <Widget>[
              Expanded(
                child: TextField(
                  decoration: const InputDecoration(
                    isDense: true,
                    prefixIcon: Icon(
                      PhosphorIconsBold.magnifyingGlass,
                      size: 18,
                    ),
                    hintText: 'Search posts',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (String v) => setState(() => _searchQuery = v),
                ),
              ),
              const SizedBox(width: 8),
              PopupMenuButton<_ForumSort>(
                icon: const Icon(PhosphorIconsBold.arrowsDownUp),
                tooltip: 'Sort & View',
                initialValue: _sort,
                onSelected: (_ForumSort s) => setState(() => _sort = s),
                itemBuilder: (BuildContext context) =>
                    const <PopupMenuEntry<_ForumSort>>[
                      PopupMenuItem<_ForumSort>(
                        value: _ForumSort.recent,
                        child: Text('Recent activity'),
                      ),
                      PopupMenuItem<_ForumSort>(
                        value: _ForumSort.name,
                        child: Text('Name (A-Z)'),
                      ),
                    ],
              ),
            ],
          ),
        ),
        if (_availableTags.isNotEmpty)
          SizedBox(
            height: 44,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              children: <Widget>[
                for (final ForumTag tag in _availableTags)
                  Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: FilterChip(
                      label: Text(tag.name),
                      selected: _tagFilter.contains(tag.id),
                      onSelected: (bool sel) {
                        setState(() {
                          if (sel) {
                            _tagFilter.add(tag.id);
                          } else {
                            _tagFilter.remove(tag.id);
                          }
                        });
                      },
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
                    return Center(child: Text('Failed to load: ${snapshot.error}'));
                  }
                  final List<Channel> posts = _visiblePosts(
                    snapshot.data ?? <Channel>[],
                  );
                  if (posts.isEmpty) {
                    return RefreshIndicator(
                      onRefresh: _onRefresh,
                      child: ListView(
                        children: <Widget>[
                          const SizedBox(height: 120),
                          Center(
                            child: Text(
                              _showArchived
                                  ? 'No archived posts'
                                  : 'No posts yet',
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                  return RefreshIndicator(
                    onRefresh: _onRefresh,
                    child: ListView.separated(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      itemCount: posts.length,
                      separatorBuilder: (_, _) => const Divider(height: 1),
                      itemBuilder: (BuildContext context, int index) =>
                          _ForumPostTile(
                            post: posts[index],
                            resolveTag: _tagById,
                            onTap: () => _openPost(posts[index]),
                            onManage: (_PostModAction a) =>
                                _moderatePost(posts[index], a),
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

class _ForumPostTile extends StatelessWidget {
  const _ForumPostTile({
    required this.post,
    required this.resolveTag,
    required this.onTap,
    required this.onManage,
  });

  final Channel post;
  final ForumTag? Function(String id) resolveTag;
  final VoidCallback onTap;
  final void Function(_PostModAction action) onManage;

  @override
  Widget build(BuildContext context) {
    final List<String> tagNames = <String>[
      for (final String id in post.appliedTags ?? const <String>[])
        if (resolveTag(id) case final ForumTag t) t.name,
    ];
    return ListTile(
      leading: Icon(
        post.threadPinned ?? false
            ? PhosphorIconsFill.pushPin
            : PhosphorIconsRegular.chatCircle,
        size: 20,
      ),
      title: Text(post.name, maxLines: 1, overflow: TextOverflow.ellipsis),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            <String>[
              if (post.threadMessageCount != null)
                '${post.threadMessageCount} messages',
              if (post.threadMemberCount != null)
                '${post.threadMemberCount} members',
              if (post.isArchived) 'Archived',
            ].join('  ·  '),
          ),
          if (tagNames.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Wrap(
                spacing: 4,
                runSpacing: 4,
                children: <Widget>[
                  for (final String name in tagNames)
                    Chip(
                      label: Text(name),
                      visualDensity: VisualDensity.compact,
                      materialTapTargetSize:
                          MaterialTapTargetSize.shrinkWrap,
                    ),
                ],
              ),
            ),
        ],
      ),
      isThreeLine: tagNames.isNotEmpty,
      trailing: PopupMenuButton<_PostModAction>(
        icon: const Icon(PhosphorIconsBold.dotsThreeVertical, size: 18),
        tooltip: 'Manage',
        onSelected: onManage,
        itemBuilder: (BuildContext context) => <PopupMenuEntry<_PostModAction>>[
          PopupMenuItem<_PostModAction>(
            value: _PostModAction.togglePin,
            child: Text((post.threadPinned ?? false) ? 'Unpin' : 'Pin'),
          ),
          PopupMenuItem<_PostModAction>(
            value: _PostModAction.toggleArchive,
            child: Text(post.isArchived ? 'Unarchive' : 'Archive'),
          ),
          PopupMenuItem<_PostModAction>(
            value: _PostModAction.toggleLock,
            child: Text(post.isLocked ? 'Unlock' : 'Lock'),
          ),
          const PopupMenuItem<_PostModAction>(
            value: _PostModAction.delete,
            child: Text('Delete'),
          ),
        ],
      ),
      onTap: onTap,
    );
  }
}

enum _PostModAction { togglePin, toggleArchive, toggleLock, delete }

enum _ForumSort { recent, name }

class _ForumPostDraft {
  const _ForumPostDraft({required this.title, required this.tagIds});

  final String title;
  final Set<String> tagIds;
}

class _NewForumPostDialog extends StatefulWidget {
  const _NewForumPostDialog({required this.availableTags});

  final List<ForumTag> availableTags;

  @override
  State<_NewForumPostDialog> createState() => _NewForumPostDialogState();
}

class _NewForumPostDialogState extends State<_NewForumPostDialog> {
  final TextEditingController _controller = TextEditingController();
  final Set<String> _selectedTags = <String>{};

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('New post'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextField(
            controller: _controller,
            autofocus: true,
            maxLength: 100,
            decoration: const InputDecoration(hintText: 'Post title'),
          ),
          if (widget.availableTags.isNotEmpty) ...<Widget>[
            const SizedBox(height: 8),
            Wrap(
              spacing: 6,
              runSpacing: 6,
              children: <Widget>[
                for (final ForumTag tag in widget.availableTags)
                  FilterChip(
                    label: Text(tag.name),
                    selected: _selectedTags.contains(tag.id),
                    onSelected: (bool sel) {
                      setState(() {
                        if (sel) {
                          _selectedTags.add(tag.id);
                        } else {
                          _selectedTags.remove(tag.id);
                        }
                      });
                    },
                  ),
              ],
            ),
          ],
        ],
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        FilledButton(
          onPressed: () => Navigator.of(context).pop(
            _ForumPostDraft(title: _controller.text, tagIds: _selectedTags),
          ),
          child: const Text('Create'),
        ),
      ],
    );
  }
}
