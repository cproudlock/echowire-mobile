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

  @override
  void initState() {
    super.initState();
    _membersFuture = _load();
  }

  Future<List<db.User>> _load() async {
    final List<String> ids = await ref
        .read(threadRepositoryProvider)
        .listThreadMemberIds(widget.channelId);
    return ref.read(fluxerDatabaseProvider).userDao.getUsersByIds(ids);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<db.User>>(
      future: _membersFuture,
      builder: (BuildContext context, AsyncSnapshot<List<db.User>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: FluxerLoadingSpinner());
        }
        if (snapshot.hasError) {
          return _EmptySheetState(
            icon: PhosphorIconsBold.users,
            title: 'Could not load members',
            body: '${snapshot.error}',
          );
        }
        final List<db.User> members = snapshot.data ?? const <db.User>[];
        if (members.isEmpty) {
          return const _EmptySheetState(
            icon: PhosphorIconsBold.users,
            title: 'No thread members yet',
            body: 'People who join this thread will appear here.',
          );
        }
        return ListView.builder(
          controller: widget.scrollController,
          padding: EdgeInsets.symmetric(horizontal: context.layout.s4),
          itemCount: members.length,
          itemBuilder: (BuildContext context, int index) {
            final db.User u = members[index];
            final String name = (u.globalName?.isNotEmpty ?? false)
                ? u.globalName!
                : u.username;
            return ListTile(
              leading: CircleAvatar(
                child: Text(
                  name.isNotEmpty ? name.substring(0, 1).toUpperCase() : '?',
                ),
              ),
              title: Text(name),
              subtitle: Text('@${u.username}'),
            );
          },
        );
      },
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
