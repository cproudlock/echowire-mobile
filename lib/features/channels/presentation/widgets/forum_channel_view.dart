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
  late Future<List<Channel>> _postsFuture;
  bool _showArchived = false;
  final Set<String> _tagFilter = <String>{};

  List<ForumTag> get _availableTags =>
      widget.channel.availableTags ?? const <ForumTag>[];

  @override
  void initState() {
    super.initState();
    _postsFuture = _load();
  }

  Future<List<Channel>> _load() {
    final ThreadRepository repo = ref.read(threadRepositoryProvider);
    return _showArchived
        ? repo.listArchivedThreads(widget.channel.id, guildId: widget.guildId)
        : repo.listActiveThreads(widget.channel.id, guildId: widget.guildId);
  }

  void _reload() => setState(() => _postsFuture = _load());

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

  List<Channel> _applyTagFilter(List<Channel> posts) {
    if (_tagFilter.isEmpty) {
      return posts;
    }
    return posts
        .where(
          (Channel p) =>
              (p.appliedTags ?? const <String>[]).any(_tagFilter.contains),
        )
        .toList();
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
                    _showArchived = s.first;
                    _reload();
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
          child: FutureBuilder<List<Channel>>(
            future: _postsFuture,
            builder:
                (BuildContext context, AsyncSnapshot<List<Channel>> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return Center(child: Text('Failed to load: ${snapshot.error}'));
                  }
                  final List<Channel> posts = _applyTagFilter(
                    snapshot.data ?? <Channel>[],
                  );
                  if (posts.isEmpty) {
                    return RefreshIndicator(
                      onRefresh: () async => _reload(),
                      child: ListView(
                        children: const <Widget>[
                          SizedBox(height: 120),
                          Center(child: Text('No posts yet')),
                        ],
                      ),
                    );
                  }
                  return RefreshIndicator(
                    onRefresh: () async => _reload(),
                    child: ListView.separated(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      itemCount: posts.length,
                      separatorBuilder: (_, _) => const Divider(height: 1),
                      itemBuilder: (BuildContext context, int index) =>
                          _ForumPostTile(
                            post: posts[index],
                            resolveTag: _tagById,
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

class _ForumPostTile extends StatelessWidget {
  const _ForumPostTile({
    required this.post,
    required this.resolveTag,
    required this.onTap,
  });

  final Channel post;
  final ForumTag? Function(String id) resolveTag;
  final VoidCallback onTap;

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
      onTap: onTap,
    );
  }
}

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
