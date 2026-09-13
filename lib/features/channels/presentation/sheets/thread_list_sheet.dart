import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluxer_app/core/router/fluxer_router.dart';
import 'package:fluxer_app/core/router/route_names.dart';
import 'package:fluxer_app/core/talker.dart';
import 'package:fluxer_app/core/theme/fluxer_theme_extension.dart';
import 'package:fluxer_app/features/channels/domain/channel.dart';
import 'package:fluxer_app/features/channels/presentation/sheets/thread_name_prompt.dart';
import 'package:fluxer_app/features/channels/presentation/widgets/thread_ui.dart';
import 'package:fluxer_app/features/channels/providers/thread_providers.dart';
import 'package:fluxer_app/features/ui/ui.dart';
import 'package:fluxer_app/l10n/generated/fluxer_localizations.dart';
import 'package:fluxer_app/material_ui.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

/// Echowire: opens the threads list for a text/forum [parentChannel].
Future<void> showThreadsSheet(
  BuildContext context, {
  required Channel parentChannel,
}) {
  final FluxerLocalizations l10n = FluxerLocalizations.of(context);
  return FluxerBottomSheet.show<void>(
    context,
    title: parentChannel.isForum ? l10n.threadsPostsTitle : l10n.threadsTitle,
    builder: (BuildContext sheetContext, VoidCallback close) =>
        _ThreadListView(parentChannel: parentChannel, close: close),
  );
}

class _ThreadListView extends ConsumerStatefulWidget {
  const _ThreadListView({required this.parentChannel, required this.close});

  final Channel parentChannel;
  final VoidCallback close;

  @override
  ConsumerState<_ThreadListView> createState() => _ThreadListViewState();
}

class _ThreadListViewState extends ConsumerState<_ThreadListView> {
  late final Stream<List<Channel>> _threadsStream;
  bool _showArchived = false;

  @override
  void initState() {
    super.initState();
    _threadsStream = ref
        .read(threadRepositoryProvider)
        .watchThreads(widget.parentChannel.id);
    _refresh();
  }

  void _refresh() {
    unawaited(
      ref
          .read(threadRepositoryProvider)
          .refreshThreads(
            widget.parentChannel.id,
            guildId: widget.parentChannel.guildId,
          ),
    );
  }

  List<Channel> _visibleThreads(List<Channel> threads) {
    final List<Channel> result = threads
        .where((Channel t) => t.isArchived == _showArchived)
        .toList();
    result.sort((Channel a, Channel b) {
      final int pin =
          ((b.threadPinned ?? false) ? 1 : 0) -
          ((a.threadPinned ?? false) ? 1 : 0);
      return pin != 0 ? pin : b.id.compareTo(a.id);
    });
    return result;
  }

  void _openThread(Channel thread) {
    widget.close();
    context.go(RoutePaths.guildChannel(thread.guildId, thread.id));
  }

  Future<void> _createThread() async {
    final FluxerLocalizations l10n = FluxerLocalizations.of(context);
    final String? name = await showThreadNamePrompt(context);
    if (name == null || name.isEmpty) {
      return;
    }
    try {
      final Channel thread = await ref
          .read(threadRepositoryProvider)
          .createThread(parentChannelId: widget.parentChannel.id, name: name);
      if (!mounted) {
        return;
      }
      _openThread(thread);
    } on Exception catch (e, st) {
      talker.error('Could not create thread', e, st);
      if (!mounted) {
        return;
      }
      showThreadToast(ref, l10n.threadsCreateFailed);
    }
  }

  String _threadSubtitle(FluxerLocalizations l10n, Channel t) {
    return <String>[
      if (t.threadMessageCount != null)
        l10n.threadsMessageCount(t.threadMessageCount!),
      if (t.threadMemberCount != null)
        l10n.threadsMemberCount(t.threadMemberCount!),
      if (t.isLocked) l10n.threadsStatusLocked,
      if (t.isArchived) l10n.threadsStatusArchived,
    ].join('  ·  ');
  }

  @override
  Widget build(BuildContext context) {
    final FluxerLocalizations l10n = FluxerLocalizations.of(context);
    final colors = context.colors;
    final layout = context.layout;
    final bool canManage = watchCanManageThreads(ref, widget.parentChannel.id);
    final String? currentUserId = ref.watch(currentUserIdProvider);

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: layout.s4,
            vertical: layout.s2,
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
              FluxerButton.primary(
                onPressed: _createThread,
                icon: PhosphorIconsBold.plus,
                label: widget.parentChannel.isForum
                    ? l10n.forumNewPost
                    : l10n.threadsNewThread,
                size: FluxerButtonSize.compact,
                fitContent: true,
              ),
            ],
          ),
        ),
        StreamBuilder<List<Channel>>(
          stream: _threadsStream,
          builder:
              (BuildContext context, AsyncSnapshot<List<Channel>> snapshot) {
                if (snapshot.hasError) {
                  return ThreadListMessage(text: l10n.threadsLoadFailed);
                }
                final List<Channel> threads = _visibleThreads(
                  snapshot.data ?? <Channel>[],
                );
                if (threads.isEmpty) {
                  return ThreadListMessage(
                    text: _showArchived
                        ? l10n.threadsNoArchived
                        : l10n.threadsNoActive,
                  );
                }
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: threads.length,
                  itemBuilder: (BuildContext context, int index) {
                    final Channel t = threads[index];
                    return FluxerListRow(
                      leading: Icon(
                        t.threadPinned ?? false
                            ? PhosphorIconsFill.pushPin
                            : PhosphorIconsRegular.chatText,
                        size: 18,
                        color: colors.textSecondary,
                      ),
                      title: t.name,
                      subtitle: _threadSubtitle(l10n, t),
                      trailing: ThreadModMenuButton(
                        thread: t,
                        actions: threadModActionsFor(
                          thread: t,
                          canManage: canManage,
                          currentUserId: currentUserId,
                        ),
                      ),
                      onTap: () => _openThread(t),
                    );
                  },
                );
              },
        ),
        SizedBox(height: layout.s2),
      ],
    );
  }
}
