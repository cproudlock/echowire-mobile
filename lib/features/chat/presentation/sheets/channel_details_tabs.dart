part of 'channel_details_sheet.dart';

class _MembersTab extends ConsumerWidget {
  const _MembersTab({
    required this.dm,
    required this.guildId,
    required this.channelId,
    required this.scrollController,
  });

  final DmConversation? dm;
  final String? guildId;
  final String? channelId;
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (dm != null) {
      final currentUserId = ref.watch(currentUserIdProvider);
      final canShowNewGroupCta =
          !dm!.isGroup && !dm!.isPersonalNotes && !dm!.isBot && !dm!.isSystem;

      return ListView(
        controller: scrollController,
        padding: FluxerBottomSheet.scrollViewPadding(
          context,
          padding: EdgeInsets.symmetric(horizontal: context.layout.s4),
        ),
        children: [
          if (canShowNewGroupCta)
            _NewGroupCtaRow(
              recipientHandle: dm!.recipientUsername ?? dm!.recipientName,
              onTap: () => unawaited(
                CreateDmFlow.show(
                  context,
                  options: CreateDmOptions(
                    initialSelectedUserIds: dm!.remoteRecipientIds,
                    duplicateExcludeChannelId: dm!.id,
                  ),
                ),
              ),
            ),
          _DmMemberGroups(dm: dm!, currentUserId: currentUserId),
        ],
      );
    }

    if (guildId == null || channelId == null) {
      final FluxerLocalizations l10n = FluxerLocalizations.of(context);
      return _EmptySheetState(
        icon: PhosphorIconsBold.users,
        title: l10n.channelDetailsMembersEmptyTitle,
        body: l10n.channelDetailsMembersEmptyBody,
      );
    }
    // Echowire: threads have their own membership; show the thread members
    // rather than the whole guild's member list.
    final Channel? channel = ref.watch(channelByIdProvider(channelId!)).value;
    if (channel != null && threadChannelTypes.contains(channel.type)) {
      return _ThreadMembersContent(
        channelId: channelId!,
        scrollController: scrollController,
      );
    }
    return GuildMembersTabContent(
      guildId: guildId!,
      channelId: channelId!,
      scrollController: scrollController,
    );
  }
}

class _ThreadMembersContent extends ConsumerStatefulWidget {
  const _ThreadMembersContent({
    required this.channelId,
    required this.scrollController,
  });

  final String channelId;
  final ScrollController scrollController;

  @override
  ConsumerState<_ThreadMembersContent> createState() =>
      _ThreadMembersContentState();
}

class _ThreadMembersContentState extends ConsumerState<_ThreadMembersContent> {
  late Future<List<db.User>> _membersFuture;
  List<String> _memberIds = const <String>[];
  bool _busy = false;

  @override
  void initState() {
    super.initState();
    _membersFuture = _load();
  }

  Future<List<db.User>> _load() async {
    try {
      final List<String> ids = await ref
          .read(threadRepositoryProvider)
          .listThreadMemberIds(widget.channelId);
      _memberIds = ids;
      return await ref.read(fluxerDatabaseProvider).userDao.getUsersByIds(ids);
    } on Exception catch (e, st) {
      talker.error('Could not load thread members', e, st);
      rethrow;
    }
  }

  void _reload() {
    setState(() {
      _membersFuture = _load();
    });
  }

  /// Say what the server refused, rather than surfacing a status line.
  String _failureMessage(FluxerLocalizations l10n, Object error) {
    return switch (error) {
      ThreadMemberException(failure: ThreadMemberFailure.full) =>
        l10n.threadsMembersFullToast,
      ThreadMemberException(failure: ThreadMemberFailure.notFound) =>
        l10n.threadsMemberNotFoundToast,
      ThreadMemberException(failure: ThreadMemberFailure.forbidden) =>
        l10n.threadsMembersForbiddenToast,
      _ => l10n.threadsActionFailed,
    };
  }

  Future<void> _runMemberAction(
    Future<void> Function() action, {
    required String successMessage,
  }) async {
    if (_busy) {
      return;
    }
    setState(() => _busy = true);
    final FluxerLocalizations l10n = FluxerLocalizations.of(context);
    try {
      await action();
      showThreadToast(ref, successMessage, variant: FluxerToastVariant.success);
      _reload();
    } on Exception catch (e, st) {
      talker.error('Thread member action failed', e, st);
      showThreadToast(ref, _failureMessage(l10n, e));
    } finally {
      if (mounted) {
        setState(() => _busy = false);
      }
    }
  }

  Future<void> _addMember(String guildId) async {
    final FluxerLocalizations l10n = FluxerLocalizations.of(context);
    final String? userId = await showThreadAddMemberModal(
      context,
      guildId: guildId,
      excludedUserIds: _memberIds.toSet(),
    );
    if (userId == null || !mounted) {
      return;
    }
    await _runMemberAction(
      () => ref
          .read(threadRepositoryProvider)
          .addThreadMember(widget.channelId, userId),
      successMessage: l10n.threadsMemberAddedToast,
    );
  }

  Future<void> _removeMember(String userId, {required bool isSelf}) async {
    final FluxerLocalizations l10n = FluxerLocalizations.of(context);
    await _runMemberAction(
      () => ref
          .read(threadRepositoryProvider)
          .removeThreadMember(widget.channelId, userId),
      successMessage: isSelf
          ? l10n.threadsLeftToast
          : l10n.threadsMemberRemovedToast,
    );
  }

  Future<void> _setInvitable(bool value) async {
    final FluxerLocalizations l10n = FluxerLocalizations.of(context);
    try {
      await ref
          .read(threadRepositoryProvider)
          .updateThread(widget.channelId, invitable: value);
    } on Exception catch (e, st) {
      talker.error('Could not set invitable on ${widget.channelId}', e, st);
      showThreadToast(ref, l10n.threadsActionFailed);
    }
  }

  @override
  Widget build(BuildContext context) {
    final FluxerLocalizations l10n = FluxerLocalizations.of(context);
    final Channel? thread = ref
        .watch(channelByIdProvider(widget.channelId))
        .value;
    final String? parentId = thread?.parentId;
    final String? currentUserId = ref.watch(currentUserIdProvider);
    final bool canManage =
        parentId != null && watchCanManageThreads(ref, parentId);
    final bool isOwner =
        currentUserId != null && thread?.ownerId == currentUserId;
    final bool invitable = thread?.threadInvitable ?? false;
    final bool amMember =
        currentUserId != null && _memberIds.contains(currentUserId);
    // The server lets the owner and thread moderators add; any member may add
    // too while the thread is invitable.
    final bool canAdd =
        thread != null && (canManage || isOwner || (invitable && amMember));
    // Invitable rides on the same rule as the thread's other editable fields.
    final bool canSetInvitable =
        thread != null &&
        canEditThreadSlowmode(
          thread: thread,
          canManage: canManage,
          currentUserId: currentUserId,
        );
    final bool isPrivate = thread?.type == ChannelType.privateThread;
    final String? guildId = thread?.guildId;

    return FutureBuilder<List<db.User>>(
      future: _membersFuture,
      builder: (BuildContext context, AsyncSnapshot<List<db.User>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: FluxerLoadingSpinner());
        }
        if (snapshot.hasError) {
          return _EmptySheetState(
            icon: PhosphorIconsBold.users,
            title: l10n.threadsMembersLoadFailed,
            body: l10n.threadsActionFailed,
          );
        }
        final List<db.User> members = snapshot.data ?? const <db.User>[];
        return ListView(
          controller: widget.scrollController,
          padding: EdgeInsets.symmetric(horizontal: context.layout.s4),
          children: <Widget>[
            if (isPrivate && canSetInvitable)
              Padding(
                padding: EdgeInsets.only(bottom: context.layout.s2),
                child: FluxerToggleSwitch(
                  value: invitable,
                  label: l10n.threadsInvitableLabel,
                  description: l10n.threadsInvitableDescription,
                  onChanged: (bool value) => unawaited(_setInvitable(value)),
                ),
              )
            else if (isPrivate && invitable)
              Padding(
                padding: EdgeInsets.only(bottom: context.layout.s2),
                child: Text(
                  l10n.threadsInvitableDescription,
                  style: context.textStyles.bodySmall.copyWith(
                    color: context.colors.textSecondary,
                  ),
                ),
              ),
            if (canAdd && guildId != null)
              Padding(
                padding: EdgeInsets.only(bottom: context.layout.s2),
                child: FluxerButton.secondary(
                  icon: PhosphorIconsBold.userPlus,
                  label: l10n.threadsAddMember,
                  onPressed: _busy
                      ? null
                      : () => unawaited(_addMember(guildId)),
                ),
              ),
            if (members.isEmpty)
              Padding(
                padding: EdgeInsets.only(top: context.layout.s6),
                child: _EmptySheetState(
                  icon: PhosphorIconsBold.users,
                  title: l10n.threadsNoMembersTitle,
                  body: l10n.threadsNoMembersBody,
                ),
              ),
            for (final db.User u in members)
              Builder(
                builder: (BuildContext context) {
                  final String name = (u.globalName?.isNotEmpty ?? false)
                      ? u.globalName!
                      : u.username;
                  final bool isSelf = u.id == currentUserId;
                  final bool canRemove = canManage || isSelf;
                  return FluxerListRow(
                    leading: FluxerAvatar(fallbackText: name),
                    title: name,
                    subtitle: '@${u.username}',
                    trailing: canRemove
                        ? FluxerButton.ghost(
                            icon: isSelf
                                ? PhosphorIconsBold.signOut
                                : PhosphorIconsBold.userMinus,
                            isSquare: true,
                            size: FluxerButtonSize.compact,
                            semanticLabel: isSelf
                                ? l10n.threadsLeaveThread
                                : l10n.threadsRemoveMember,
                            onPressed: _busy
                                ? null
                                : () => unawaited(
                                    _removeMember(u.id, isSelf: isSelf),
                                  ),
                          )
                        : null,
                  );
                },
              ),
          ],
        );
      },
    );
  }
}

/// Pick a guild member to add to a thread. Mirrors the member search the
/// channel override popout uses, filtered to people not already in the thread.
Future<String?> showThreadAddMemberModal(
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

class _PinsTab extends ConsumerWidget {
  const _PinsTab({
    required this.channelId,
    required this.guildId,
    required this.scrollController,
    required this.close,
  });

  final String channelId;
  final String? guildId;
  final ScrollController scrollController;
  final VoidCallback close;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pins = ref.watch(channelPinsProvider(channelId));
    return pins.when(
      loading: () => const Center(child: FluxerLoadingSpinner()),
      error: (error, stack) => _ErrorSheetState(
        title: FluxerLocalizations.of(
          context,
        ).channelDetailsPinsLoadFailedTitle,
        onRetry: () => ref.invalidate(channelPinsProvider(channelId)),
      ),
      data: (state) {
        if (state.items.isEmpty) {
          return const _PinsEmptyState();
        }

        final FluxerLocalizations l10n = FluxerLocalizations.of(context);
        final endStateDescription = guildId != null
            ? l10n.channelDetailsPinsGuildEndHint
            : l10n.channelDetailsPinsDmEndHint;

        return ListView.builder(
          controller: scrollController,
          padding: FluxerBottomSheet.scrollViewPadding(
            context,
            padding: EdgeInsets.symmetric(horizontal: context.layout.s4),
          ),
          itemCount:
              state.items.length +
              (state.isLoadingMore ||
                      state.errorMessage != null ||
                      !state.hasMore
                  ? 1
                  : 0),
          itemBuilder: (context, index) {
            if (index >= state.items.length) {
              if (state.errorMessage != null) {
                return _InlineRetry(
                  message: state.errorMessage!,
                  onRetry: () => ref
                      .read(channelPinsProvider(channelId).notifier)
                      .loadMore(),
                );
              }
              if (state.isLoadingMore) {
                return const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: Center(child: FluxerLoadingSpinner()),
                );
              }
              return _PinsEndState(description: endStateDescription);
            }
            final entry = state.items[index];
            return MessagePreviewTile(
              message: entry.message,
              guildId: guildId,
              onTap: () => _popWithJumpRequest(
                context,
                message: entry.message,
                guildId: guildId,
              ),
              onLongPress: () => _showPinnedMessageActions(
                context,
                ref,
                channelId: channelId,
                guildId: guildId,
                entry: entry,
              ),
            );
          },
        );
      },
    );
  }
}

class _PinsEmptyState extends StatelessWidget {
  const _PinsEmptyState();

  @override
  Widget build(BuildContext context) {
    final l10n = FluxerLocalizations.of(context);
    return Center(
      child: Padding(
        padding: EdgeInsets.all(context.layout.s6),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            PhosphorIcon(
              PhosphorIconsBold.sparkle,
              size: 80,
              color: context.colors.textPrimaryMuted,
            ),
            const SizedBox(height: 12),
            Text(
              l10n.channelPinsEmptyTitle,
              style: context.textStyles.heading.copyWith(
                color: context.colors.textPrimary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 4),
            Text(
              l10n.channelPinsEmptyDescription,
              style: context.textStyles.bodySmall.copyWith(
                color: context.colors.textPrimaryMuted,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class _PinsEndState extends StatelessWidget {
  const _PinsEndState({required this.description});

  final String description;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            PhosphorIcon(
              PhosphorIconsFill.flagCheckered,
              size: 48,
              color: context.colors.textPrimaryMuted,
            ),
            const SizedBox(height: 8),
            Text(
              FluxerLocalizations.of(context).channelDetailsPinsEndReached,
              style: context.textStyles.heading.copyWith(
                color: context.colors.textPrimary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 4),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                description,
                style: context.textStyles.bodySmall.copyWith(
                  color: context.colors.textPrimaryMuted,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MessagePreviewTile extends StatelessWidget {
  const MessagePreviewTile({
    required this.message,
    required this.onTap,
    this.label,
    this.onLongPress,
    this.guildId,
    super.key,
  });

  final Message message;
  final String? label;
  final String? guildId;
  final VoidCallback onTap;
  final VoidCallback? onLongPress;

  @override
  Widget build(BuildContext context) {
    final hasLabel = label != null && label!.isNotEmpty;
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Material(
        color: context.colors.backgroundModifierHover,
        borderRadius: BorderRadius.circular(14),
        child: InkWell(
          onTap: onTap,
          onLongPress: onLongPress,
          borderRadius: BorderRadius.circular(14),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (hasLabel)
                  Padding(
                    padding: const EdgeInsets.fromLTRB(12, 0, 12, 4),
                    child: Text(
                      label!,
                      style: context.textStyles.timestamp.copyWith(
                        color: context.colors.textTertiary,
                      ),
                    ),
                  ),
                MessageItem(
                  message: message,
                  inboxPreviewMode: true,
                  hideMentionHighlight: true,
                  previewRoleGuildId: guildId,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
