import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluxer_app/core/api/fluxer_client_provider.dart';
import 'package:fluxer_app/core/bootstrap/image_cache_config.dart';
import 'package:fluxer_app/core/providers/gateway_connection_provider.dart';
import 'package:fluxer_app/features/profile/providers/user_settings_status_provider.dart';
import 'package:fluxer_app/l10n/app_locale_provider.dart';
import 'package:fluxer_dart/gateway.dart';
import 'package:fluxer_app/core/audio/app_media_audio_session.dart';
import 'package:fluxer_app/core/bootstrap/image_cache_config.dart';
import 'package:fluxer_app/core/providers/well_known_provider.dart';
import 'package:fluxer_app/features/chat/utils/media_kit_player_lifecycle.dart';
import 'package:fluxer_app/l10n/app_locale_provider.dart';
import 'package:fluxer_app/shared/external_links/external_url_launcher.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_ui_lifecycle_provider.g.dart';

bool isAppUiForegroundLifecycle(AppLifecycleState state) {
  return state == AppLifecycleState.resumed ||
      state == AppLifecycleState.inactive;
}

bool shouldCloseInAppBrowserOnLifecycleResume({
  required bool wasForeground,
  required AppLifecycleState state,
}) {
  return !wasForeground && isAppUiForegroundLifecycle(state);
}

/// True while the app is visible (resumed or briefly inactive)
@Riverpod(keepAlive: true)
class AppUiForeground extends _$AppUiForeground {
  @override
  bool build() {
    final AppLifecycleState? s = WidgetsBinding.instance.lifecycleState;
    return s == null || isAppUiForegroundLifecycle(s);
  }

  // Keep the notifier API stable for tests and lifecycle call sites.
  // ignore: use_setters_to_change_properties, avoid_positional_boolean_parameters
  void setResumed(bool value) {
    state = value;
  }
}

/// Pushes platform lifecycle and locale changes into Riverpod state.
class AppUiLifecycleObserver extends ConsumerStatefulWidget {
  const AppUiLifecycleObserver({required this.child, super.key});

  final Widget child;

  @override
  ConsumerState<AppUiLifecycleObserver> createState() =>
      _AppUiLifecycleObserverState();
}

class _AppUiLifecycleObserverState extends ConsumerState<AppUiLifecycleObserver>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) {
        return;
      }
      _syncLifecycle(WidgetsBinding.instance.lifecycleState);
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    _syncLifecycle(state);
  }

  @override
  void didChangeLocales(List<Locale>? locales) {
    super.didChangeLocales(locales);
    ref.read(systemLocalesProvider.notifier).updateFromPlatform(locales);
  }

  void _syncLifecycle(AppLifecycleState? state) {
    if (!mounted || state == null) {
      return;
    }
    if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.hidden) {
      clearFluxerImageCache();
      unawaited(MediaKitPlayerLifecycleCoordinator.instance.pauseAll());
    }
    final bool wasForeground = ref.read(appUiForegroundProvider);
    final bool isForeground = isAppUiForegroundLifecycle(state);
    if (shouldCloseInAppBrowserOnLifecycleResume(
      wasForeground: wasForeground,
      state: state,
    )) {
      unawaited(closeInAppBrowserIfOpen());
    }
    ref.read(appUiForegroundProvider.notifier).setResumed(isForeground);
    if (!wasForeground && isForeground) {
      unawaited(ref.read(wellKnownProvider.notifier).refresh());
    }
    if (!kIsWeb &&
        (Platform.isIOS || Platform.isAndroid) &&
        isForeground &&
        !wasForeground) {
      unawaited(prepareAppMediaAudioSession());
    }
    ref
        .read(appUiForegroundProvider.notifier)
        .setResumed(isAppUiForegroundLifecycle(state));
    _syncAfkPresence(state);
  }

  /// Marks the gateway session AFK while the app is backgrounded.
  ///
  /// The gateway BUFFERS (does not send) push notifications for a message while
  /// the recipient has a connected, non-AFK session — `is_push_eligible` in
  /// presence_update.erl requires `all_sessions_afk`. A backgrounded mobile app
  /// stays connected but never marked AFK, so DM pushes are buffered; when the
  /// user reopens the app and reads the message, the ack CLEARS the buffered
  /// push (maybe_ack_push_buffer) and it never fires. Sending `afk=true` on
  /// background makes the session push-eligible so the gateway sends the FCM
  /// immediately. `updatePresence` also stores the presence, so it re-sends on
  /// the next identify/reconnect. (Fully-offline delivery is handled separately
  /// by the gateway's handle_offline_dispatch.)
  void _syncAfkPresence(AppLifecycleState state) {
    final bool afk;
    switch (state) {
      case AppLifecycleState.paused:
      case AppLifecycleState.hidden:
        afk = true;
      case AppLifecycleState.resumed:
        afk = false;
      case AppLifecycleState.inactive:
      case AppLifecycleState.detached:
        return; // transient/terminal — don't toggle presence
    }
    // No live gateway connection without an auth token (reading the provider
    // would throw); nothing to update until the user is signed in.
    if (ref.read(fluxerAuthTokenProvider) == null) {
      return;
    }
    final GatewayConnection connection = ref.read(gatewayConnectionProvider);
    final String status =
        ref.read(userSettingsStatusProvider)?.status ?? 'online';
    connection.updatePresence(
      GatewayPresence(status: status, afk: afk, mobile: true),
    );
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
