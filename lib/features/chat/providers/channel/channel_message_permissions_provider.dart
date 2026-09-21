import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluxer_app/core/permissions/channel_effective_permissions.dart';
import 'package:fluxer_app/core/permissions/channel_permission_cache_provider.dart';
import 'package:fluxer_app/core/permissions/permission.dart';
import 'package:fluxer_app/core/providers/database_provider.dart';
import 'package:fluxer_app/core/router/fluxer_router.dart';
import 'package:fluxer_app/features/channels/domain/channel.dart';
import 'package:fluxer_app/features/channels/providers/channel_providers.dart';
import 'package:fluxer_app/features/dm/domain/dm_channel_types.dart';
import 'package:fluxer_app/features/dm/domain/dm_conversation.dart';
import 'package:fluxer_app/features/dm/providers/dm_view_model.dart';
import 'package:fluxer_app/features/guilds/providers/guild_list_view_model.dart';
import 'package:fluxer_app/features/members/providers/member_providers.dart';
import 'package:fluxer_app/shared/utils/chat_context_utils.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'channel_message_permissions_provider.g.dart';

/// Effective flags for the message composer from guild base bits, roles, and
/// channel/category permission overwrites stored on local channel rows.
class ChannelMessagePermissions {
  final bool isResolved;
  final bool canSendMessages;
  final bool canAttachFiles;
  final bool canEmbedLinks;
  final bool canUseExternalEmojis;
  final bool canUseExternalStickers;

  const ChannelMessagePermissions({
    required this.isResolved,
    required this.canSendMessages,
    required this.canAttachFiles,
    required this.canEmbedLinks,
    required this.canUseExternalEmojis,
    required this.canUseExternalStickers,
  });

  /// Guild channel permissions are not loaded yet; composer stays enabled.
  static const ChannelMessagePermissions unresolved = ChannelMessagePermissions(
    isResolved: false,
    canSendMessages: true,
    canAttachFiles: true,
    canEmbedLinks: true,
    canUseExternalEmojis: true,
    canUseExternalStickers: true,
  );

  static const ChannelMessagePermissions none = ChannelMessagePermissions(
    isResolved: true,
    canSendMessages: false,
    canAttachFiles: false,
    canEmbedLinks: false,
    canUseExternalEmojis: false,
    canUseExternalStickers: false,
  );

  static const ChannelMessagePermissions all = ChannelMessagePermissions(
    isResolved: true,
    canSendMessages: true,
    canAttachFiles: true,
    canEmbedLinks: true,
    canUseExternalEmojis: true,
    canUseExternalStickers: true,
  );

  /// Echowire: why a thread's composer is restricted, if it is.
  ThreadComposerNotice get threadNotice => ThreadComposerNotice.none;

  bool get isComposerEnabled => !isResolved || canSendMessages;

  bool get showsNoSendPermissionHint => isResolved && !canSendMessages;

  bool get canShowAttachControls =>
      isComposerEnabled && (!isResolved || canAttachFiles);

  bool get isAttachEnabled => canShowAttachControls;

  bool get canShowEmbedControls =>
      isComposerEnabled && (!isResolved || canEmbedLinks);

  bool get isVoiceEnabled =>
      isComposerEnabled && (!isResolved || canAttachFiles);
}

/// Echowire: a thread state the composer should explain.
enum ThreadComposerNotice {
  none,

  /// Archived but not locked: sending reopens the thread.
  archived,

  /// Locked and the user cannot moderate: sending is blocked.
  locked,
}

/// Echowire: composer permissions narrowed by a thread's archive/lock state.
class _ThreadComposerPermissions extends ChannelMessagePermissions {
  _ThreadComposerPermissions(
    ChannelMessagePermissions base, {
    required this.threadNotice,
  }) : super(
         isResolved:
             base.isResolved || threadNotice == ThreadComposerNotice.locked,
         canSendMessages:
             base.canSendMessages &&
             threadNotice != ThreadComposerNotice.locked,
         canAttachFiles: base.canAttachFiles,
         canEmbedLinks: base.canEmbedLinks,
         canUseExternalEmojis: base.canUseExternalEmojis,
         canUseExternalStickers: base.canUseExternalStickers,
       );

  @override
  final ThreadComposerNotice threadNotice;
}

/// Echowire: applies the thread lock/archive rules to [base] for [channelId].
/// A locked thread only accepts messages from users who can manage channels on
/// its parent; an archived, unlocked thread reopens when someone sends.
ChannelMessagePermissions _applyThreadState(
  WidgetRef ref,
  String channelId,
  ChannelMessagePermissions base, {
  required bool watch,
}) {
  final AsyncValue<Channel?> channelAsync = watch
      ? ref.watch(channelByIdProvider(channelId))
      : ref.read(channelByIdProvider(channelId));
  final Channel? channel = channelAsync.value;
  if (channel == null || !channel.isThread) {
    return base;
  }
  final String? parentId = channel.parentId;
  if (channel.isLocked) {
    final int parentBits = parentId == null
        ? 0
        : (watch
                      ? ref.watch(
                          effectiveGuildChannelPermissionBitsProvider(parentId),
                        )
                      : ref.read(
                          effectiveGuildChannelPermissionBitsProvider(parentId),
                        ))
                  .value ??
              0;
    if (!hasPermission(parentBits, Permission.manageChannels)) {
      return _ThreadComposerPermissions(
        base,
        threadNotice: ThreadComposerNotice.locked,
      );
    }
  }
  if (channel.isArchived) {
    return _ThreadComposerPermissions(
      base,
      threadNotice: ThreadComposerNotice.archived,
    );
  }
  return base;
}

ChannelMessagePermissions channelMessagePermissionsFromBits({
  required int bits,
  required ChannelType channelType,
}) {
  return ChannelMessagePermissions(
    isResolved: true,
    canSendMessages: hasPermission(bits, Permission.sendMessages),
    canAttachFiles: hasPermission(bits, Permission.attachFiles),
    canEmbedLinks: hasPermission(bits, Permission.embedLinks),
    canUseExternalEmojis: hasPermission(bits, Permission.useExternalEmojis),
    canUseExternalStickers: hasPermission(bits, Permission.useExternalStickers),
  );
}

@riverpod
Future<ChannelMessagePermissions> channelMessagePermissions(
  Ref ref,
  String channelId,
) async {
  if (channelId.isEmpty) {
    return ChannelMessagePermissions.none;
  }
  final bool isDmChannel = ref.watch(
    dmViewModelProvider.select(
      (state) => findDmById(state.conversations, channelId) != null,
    ),
  );
  if (isDmChannel) {
    final dm = findDmById(
      ref.watch(dmViewModelProvider.select((state) => state.conversations)),
      channelId,
    );
    if (dm != null && isSystemDmConversation(dm)) {
      return ChannelMessagePermissions.none;
    }
    return ChannelMessagePermissions.all;
  }
  final String? currentUserId = ref.watch(currentUserIdProvider);
  if (isPersonalNotesChannelRoute(
    channelId: channelId,
    currentUserId: currentUserId,
  )) {
    return ChannelMessagePermissions.all;
  }
  final dmRow = await ref
      .read(fluxerDatabaseProvider)
      .dmChannelDao
      .getDmChannelById(channelId);
  if (dmRow != null && isDmPersonalNotesType(dmRow.type)) {
    return ChannelMessagePermissions.all;
  }
  await ref.watch(channelPermissionIdentityProvider(channelId).future);
  final channelRow = await ref
      .read(fluxerDatabaseProvider)
      .channelDao
      .getChannelById(channelId);
  if (channelRow == null) {
    return ChannelMessagePermissions.none;
  }
  final Channel channel = Channel.fromRow(channelRow);
  if (channel.guildId.isEmpty) {
    return ChannelMessagePermissions.none;
  }
  final String guildId = channel.guildId;
  ref
    ..watch(guildListViewModelProvider)
    ..watch(currentUserMemberIdentityProvider(guildId))
    ..watch(guildRolePermissionsIdentityProvider(guildId))
    ..watch(channelPermissionCacheProvider);
  final int? cachedBits = ref
      .read(channelPermissionCacheProvider.notifier)
      .getChannelBits(channelId);
  if (cachedBits == null) {
    await ref
        .read(channelPermissionCacheProvider.notifier)
        .rebuildChannel(channelId);
    final int? bitsAfterRebuild = ref
        .read(channelPermissionCacheProvider.notifier)
        .getChannelBits(channelId);
    if (bitsAfterRebuild == null) {
      return ChannelMessagePermissions.unresolved;
    }
    return channelMessagePermissionsFromBits(
      bits: bitsAfterRebuild,
      channelType: channel.type,
    );
  }
  return channelMessagePermissionsFromBits(
    bits: cachedBits,
    channelType: channel.type,
  );
}

ChannelMessagePermissions channelMessagePermissionsForComposer(
  AsyncValue<ChannelMessagePermissions> async,
) {
  return async.when(
    skipLoadingOnReload: true,
    data: (ChannelMessagePermissions value) => value,
    error: (Object _, StackTrace _) => ChannelMessagePermissions.unresolved,
    loading: () => ChannelMessagePermissions.unresolved,
  );
}

/// Resolves composer permissions synchronously when possible
ChannelMessagePermissions? syncChannelMessagePermissions(
  WidgetRef ref,
  String channelId, {
  required bool watch,
}) {
  if (channelId.isEmpty) {
    return ChannelMessagePermissions.none;
  }
  final DmViewState dmState = watch
      ? ref.watch(dmViewModelProvider)
      : ref.read(dmViewModelProvider);
  final DmConversation? dm = findDmById(dmState.conversations, channelId);
  if (dm != null) {
    if (isSystemDmConversation(dm)) {
      return ChannelMessagePermissions.none;
    }
    return ChannelMessagePermissions.all;
  }
  final String? currentUserId = watch
      ? ref.watch(currentUserIdProvider)
      : ref.read(currentUserIdProvider);
  if (isPersonalNotesChannelRoute(
    channelId: channelId,
    currentUserId: currentUserId,
  )) {
    return ChannelMessagePermissions.all;
  }
  final int? cachedBits = watch
      ? ref.watch(
          channelPermissionCacheProvider.select(
            (ChannelPermissionCaches caches) => caches.effective[channelId],
          ),
        )
      : ref.read(
          channelPermissionCacheProvider.select(
            (ChannelPermissionCaches caches) => caches.effective[channelId],
          ),
        );
  if (cachedBits != null) {
    return channelMessagePermissionsFromBits(
      bits: cachedBits,
      channelType: ChannelType.guildText,
    );
  }
  return null;
}

ChannelMessagePermissions watchChannelMessagePermissionsForComposer(
  WidgetRef ref,
  String channelId,
) {
  final ChannelMessagePermissions? sync = syncChannelMessagePermissions(
    ref,
    channelId,
    watch: true,
  );
  if (sync != null) {
    ref.watch(channelMessagePermissionsProvider(channelId));
    return _applyThreadState(ref, channelId, sync, watch: true);
  }
  return _applyThreadState(
    ref,
    channelId,
    channelMessagePermissionsForComposer(
      ref.watch(channelMessagePermissionsProvider(channelId)),
    ),
    watch: true,
  );
}

ChannelMessagePermissions readChannelMessagePermissionsForComposer(
  WidgetRef ref,
  String channelId,
) {
  final ChannelMessagePermissions? sync = syncChannelMessagePermissions(
    ref,
    channelId,
    watch: false,
  );
  if (sync != null) {
    return _applyThreadState(ref, channelId, sync, watch: false);
  }
  return _applyThreadState(
    ref,
    channelId,
    channelMessagePermissionsForComposer(
      ref.read(channelMessagePermissionsProvider(channelId)),
    ),
    watch: false,
  );
}
