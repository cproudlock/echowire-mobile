import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluxer_app/core/router/route_names.dart';
import 'package:fluxer_app/features/channels/data/thread_repository.dart';
import 'package:fluxer_app/features/channels/domain/channel.dart';
import 'package:fluxer_app/features/channels/providers/thread_providers.dart';
import 'package:fluxer_app/features/ui/bottom_sheet/fluxer_bottom_sheet.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

/// Echowire: opens the threads list for a text/forum [parentChannel].
Future<void> showThreadsSheet(
  BuildContext context, {
  required Channel parentChannel,
}) {
  return FluxerBottomSheet.show<void>(
    context,
    title: parentChannel.isForum ? 'Posts' : 'Threads',
    builder: (BuildContext sheetContext, VoidCallback close) =>
        _ThreadListView(parentChannel: parentChannel, close: close),
  );
}

enum _ThreadModAction { togglePin, toggleArchive, toggleLock, delete }

class _ThreadListView extends ConsumerStatefulWidget {
  const _ThreadListView({required this.parentChannel, required this.close});

  final Channel parentChannel;
  final VoidCallback close;

  @override
  ConsumerState<_ThreadListView> createState() => _ThreadListViewState();
}

class _ThreadListViewState extends ConsumerState<_ThreadListView> {
  late Future<List<Channel>> _threadsFuture;
  bool _showArchived = false;

  @override
  void initState() {
    super.initState();
    _threadsFuture = _load();
  }

  Future<List<Channel>> _load() {
    final ThreadRepository repo = ref.read(threadRepositoryProvider);
    return _showArchived
        ? repo.listArchivedThreads(
            widget.parentChannel.id,
            guildId: widget.parentChannel.guildId,
          )
        : repo.listActiveThreads(
            widget.parentChannel.id,
            guildId: widget.parentChannel.guildId,
          );
  }

  void _reload() => setState(() => _threadsFuture = _load());

  void _openThread(Channel thread) {
    widget.close();
    context.go(RoutePaths.guildChannel(thread.guildId, thread.id));
  }

  Future<void> _createThread() async {
    final String? name = await _promptThreadName(context);
    if (name == null || name.trim().isEmpty) {
      return;
    }
    try {
      final Channel thread = await ref
          .read(threadRepositoryProvider)
          .createThread(
            parentChannelId: widget.parentChannel.id,
            name: name.trim(),
          );
      _openThread(thread);
    } on Exception catch (e) {
      if (!mounted) {
        return;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not create thread: $e')),
      );
    }
  }

  Widget _buildModMenu(Channel t) {
    return PopupMenuButton<_ThreadModAction>(
      icon: const Icon(PhosphorIconsBold.dotsThreeVertical, size: 18),
      tooltip: 'Manage',
      onSelected: (_ThreadModAction a) => _moderate(t, a),
      itemBuilder: (BuildContext context) =>
          <PopupMenuEntry<_ThreadModAction>>[
            PopupMenuItem<_ThreadModAction>(
              value: _ThreadModAction.togglePin,
              child: Text((t.threadPinned ?? false) ? 'Unpin' : 'Pin'),
            ),
            PopupMenuItem<_ThreadModAction>(
              value: _ThreadModAction.toggleArchive,
              child: Text(t.isArchived ? 'Unarchive' : 'Archive'),
            ),
            PopupMenuItem<_ThreadModAction>(
              value: _ThreadModAction.toggleLock,
              child: Text(t.isLocked ? 'Unlock' : 'Lock'),
            ),
            const PopupMenuItem<_ThreadModAction>(
              value: _ThreadModAction.delete,
              child: Text('Delete'),
            ),
          ],
    );
  }

  Future<void> _moderate(Channel t, _ThreadModAction action) async {
    final ThreadRepository repo = ref.read(threadRepositoryProvider);
    try {
      switch (action) {
        case _ThreadModAction.togglePin:
          await repo.updateThread(t.id, pinned: !(t.threadPinned ?? false));
        case _ThreadModAction.toggleArchive:
          await repo.updateThread(t.id, archived: !t.isArchived);
        case _ThreadModAction.toggleLock:
          await repo.updateThread(t.id, locked: !t.isLocked);
        case _ThreadModAction.delete:
          await repo.deleteThread(t.id);
      }
      _reload();
    } on Exception catch (e) {
      if (!mounted) {
        return;
      }
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Action failed: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
                onPressed: _createThread,
                icon: const Icon(PhosphorIconsBold.plus, size: 16),
                label: Text(widget.parentChannel.isForum ? 'Post' : 'New'),
              ),
            ],
          ),
        ),
        FutureBuilder<List<Channel>>(
          future: _threadsFuture,
          builder:
              (BuildContext context, AsyncSnapshot<List<Channel>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Padding(
                    padding: EdgeInsets.all(32),
                    child: Center(child: CircularProgressIndicator()),
                  );
                }
                if (snapshot.hasError) {
                  return Padding(
                    padding: const EdgeInsets.all(24),
                    child: Center(
                      child: Text('Failed to load: ${snapshot.error}'),
                    ),
                  );
                }
                final List<Channel> threads = snapshot.data ?? <Channel>[];
                if (threads.isEmpty) {
                  return Padding(
                    padding: const EdgeInsets.all(32),
                    child: Center(
                      child: Text(
                        _showArchived
                            ? 'No archived threads'
                            : 'No active threads yet',
                      ),
                    ),
                  );
                }
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: threads.length,
                  itemBuilder: (BuildContext context, int index) {
                    final Channel t = threads[index];
                    return ListTile(
                      leading: Icon(
                        t.threadPinned ?? false
                            ? PhosphorIconsFill.pushPin
                            : PhosphorIconsRegular.chatText,
                        size: 18,
                      ),
                      title: Text(t.name),
                      subtitle: Text(
                        <String>[
                          if (t.threadMessageCount != null)
                            '${t.threadMessageCount} messages',
                          if (t.threadMemberCount != null)
                            '${t.threadMemberCount} members',
                          if (t.isLocked) 'Locked',
                          if (t.isArchived) 'Archived',
                        ].join('  ·  '),
                      ),
                      trailing: _buildModMenu(t),
                      onTap: () => _openThread(t),
                    );
                  },
                );
              },
        ),
        const SizedBox(height: 8),
      ],
    );
  }
}

Future<String?> _promptThreadName(BuildContext context) {
  final TextEditingController controller = TextEditingController();
  return showDialog<String>(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      title: const Text('New thread'),
      content: TextField(
        controller: controller,
        autofocus: true,
        maxLength: 100,
        decoration: const InputDecoration(hintText: 'Thread name'),
        onSubmitted: (String v) => Navigator.of(context).pop(v),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        FilledButton(
          onPressed: () => Navigator.of(context).pop(controller.text),
          child: const Text('Create'),
        ),
      ],
    ),
  );
}
