// Echowire: add a member to a thread.
//
// Upstream ships `ThreadsRepository.addMember`, the `canAddThreadMember`
// permission check and the REST route, but no UI that uses them. This file is
// the whole extra: a button for the thread members list and the member picker
// behind it. Upstream's `ThreadMembersList` calls [EchowireThreadAddMemberButton]
// at one place, so a merge that reshapes that list only has to keep that call.
//
// Listed in docs/upstream-divergence.md. Tests:
// test/features/threads/echowire_thread_add_member_test.dart.
import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluxer_app/core/permissions/thread_permissions.dart';
import 'package:fluxer_app/core/talker.dart';
import 'package:fluxer_app/core/theme/fluxer_theme_extension.dart';
import 'package:fluxer_app/features/channels/domain/channel.dart';
import 'package:fluxer_app/features/members/data/guild_mention_member_search.dart';
import 'package:fluxer_app/features/members/domain/member.dart';
import 'package:fluxer_app/features/members/providers/member_providers.dart';
import 'package:fluxer_app/features/threads/data/threads_repository.dart';
import 'package:fluxer_app/features/threads/providers/thread_member_list_provider.dart';
import 'package:fluxer_app/features/threads/providers/thread_ui_providers.dart';
import 'package:fluxer_app/features/threads/utils/thread_actions.dart';
import 'package:fluxer_app/features/ui/ui.dart';
import 'package:fluxer_app/l10n/generated/fluxer_localizations.dart';
import 'package:fluxer_app/material_ui.dart';
import 'package:fluxer_dart/gateway.dart';

/// Whether [actor] may add somebody to the thread, before a target is chosen.
///
/// The target-dependent checks (can the target see the parent, is the target a
/// moderator) are answered by the server when the member is added, so this
/// only hides the button from people who could never add anyone.
bool echowireCanOfferAddMember(ThreadActorContext? actor) {
  if (actor == null) {
    return false;
  }
  return canAddThreadMember(
        actor,
        targetCanViewParent: true,
        targetIsModerator: false,
      ) ==
      null;
}

/// The "Add member" row shown above the member list of a thread.
class EchowireThreadAddMemberButton extends ConsumerWidget {
  const EchowireThreadAddMemberButton({
    required this.thread,
    required this.hostContext,
    super.key,
  });

  final Channel thread;
  final BuildContext hostContext;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ThreadActorContext? actor = ref.watch(
      threadActorContextProvider(thread.id),
    );
    if (!echowireCanOfferAddMember(actor)) {
      return const SizedBox.shrink();
    }
    final FluxerLocalizations l10n = FluxerLocalizations.of(context);
    return Padding(
      padding: EdgeInsets.only(bottom: context.layout.s3),
      child: FluxerButton.secondary(
        label: l10n.threadsAddMember,
        onPressed: () =>
            unawaited(echowireAddThreadMember(hostContext, ref, thread)),
      ),
    );
  }
}

/// Opens the picker and adds the chosen guild member to [thread].
Future<bool> echowireAddThreadMember(
  BuildContext context,
  WidgetRef ref,
  Channel thread,
) async {
  final Set<String> existing = <String>{
    for (final ThreadMemberEntry entry
        in ref.read(threadMemberListProvider(thread.id)) ??
            const <ThreadMemberEntry>[])
      entry.userId,
  };
  final String? userId = await showEchowireThreadAddMemberPicker(
    context,
    guildId: thread.guildId,
    excludedUserIds: existing,
  );
  if (userId == null || !context.mounted) {
    return false;
  }
  return runThreadAction(
    context,
    ref,
    (ThreadsRepository repo) => repo.addMember(
      guildId: thread.guildId,
      threadId: thread.id,
      userId: userId,
    ),
    successMessage: FluxerLocalizations.of(context).threadsMemberAddedToast,
  );
}

/// Pick a guild member to add to a thread. Mirrors the member search the
/// channel override popout uses, filtered to people not already in the thread.
Future<String?> showEchowireThreadAddMemberPicker(
  BuildContext context, {
  required String guildId,
  required Set<String> excludedUserIds,
}) {
  final FluxerLocalizations l10n = FluxerLocalizations.of(context);
  return FluxerModal.show<String>(
    context,
    title: l10n.threadsAddMember,
    builder: (BuildContext modalContext, VoidCallback close) =>
        _ThreadAddMemberBody(
          guildId: guildId,
          excludedUserIds: excludedUserIds,
          onPicked: (String userId) =>
              Navigator.of(modalContext).pop<String>(userId),
        ),
  );
}

class _ThreadAddMemberBody extends ConsumerStatefulWidget {
  const _ThreadAddMemberBody({
    required this.guildId,
    required this.excludedUserIds,
    required this.onPicked,
  });

  final String guildId;
  final Set<String> excludedUserIds;
  final ValueChanged<String> onPicked;

  @override
  ConsumerState<_ThreadAddMemberBody> createState() =>
      _ThreadAddMemberBodyState();
}

class _ThreadAddMemberBodyState extends ConsumerState<_ThreadAddMemberBody> {
  final TextEditingController _query = TextEditingController();
  List<Member> _members = const <Member>[];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    unawaited(_search(''));
  }

  @override
  void dispose() {
    _query.dispose();
    super.dispose();
  }

  Future<void> _search(String query) async {
    setState(() => _loading = true);
    try {
      final GuildMentionSnapshot snapshot = await ref
          .read(guildMentionMemberSearchProvider)
          .ensureSnapshot(widget.guildId);
      final String needle = query.trim().toLowerCase();
      final List<Member> matches = <Member>[
        for (final Member m in snapshot.members)
          if (!widget.excludedUserIds.contains(m.id) &&
              (needle.isEmpty ||
                  m.displayName.toLowerCase().contains(needle) ||
                  m.username.toLowerCase().contains(needle)))
            m,
      ];
      if (!mounted) {
        return;
      }
      setState(() {
        _members = matches.take(50).toList();
        _loading = false;
      });
    } on Object catch (e, st) {
      talker.error('Could not search members to add', e, st);
      if (mounted) {
        setState(() => _loading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final FluxerLocalizations l10n = FluxerLocalizations.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        FluxerInput(
          controller: _query,
          label: l10n.threadsAddMemberSearchLabel,
          autofocus: true,
          onChanged: (String value) => unawaited(_search(value)),
        ),
        SizedBox(height: context.layout.s3),
        if (_loading)
          const Center(child: FluxerLoadingSpinner())
        else if (_members.isEmpty)
          Padding(
            padding: EdgeInsets.symmetric(vertical: context.layout.s4),
            child: Text(
              l10n.threadsAddMemberNoResults,
              style: context.textStyles.bodySmall.copyWith(
                color: context.colors.textSecondary,
              ),
            ),
          )
        else
          ConstrainedBox(
            constraints: const BoxConstraints(maxHeight: 320),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: _members.length,
              itemBuilder: (BuildContext context, int index) {
                final Member m = _members[index];
                return FluxerListRow(
                  leading: FluxerAvatar(fallbackText: m.displayName),
                  title: m.displayName,
                  subtitle: '@${m.username}',
                  onTap: () => widget.onPicked(m.id),
                );
              },
            ),
          ),
      ],
    );
  }
}
