// Echowire: this is the FCM implementation the android-fcm build profile installs
// (tool/configure_build.dart copies it over the active file). It receives RAW FCM
// messages through packages/fluxer_fcm, which is what this fork's server sends. Upstream's
// template of the same name decodes relay ciphertext in its own pipeline instead, and
// would silently stop echowire push. Keep this file at the fork version when merging; the
// guard test in test/build/conditional_compilation_test.dart fails if it is replaced.
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:fluxer_app/core/build/push_provider_guard.dart';
import 'package:fluxer_app/core/push/fcm/fcm_android_system_notification_cancel_bridge.dart';
import 'package:fluxer_app/core/push/fcm/fcm_background_handler_policy.dart';
import 'package:fluxer_app/core/push/fcm/fcm_pending_notification_tap.dart';
import 'package:fluxer_app/core/push/fcm/fcm_tap_payload_cache.dart';
import 'package:fluxer_fcm/fcm_background_handler.dart';
import 'package:fluxer_fcm/fcm_push_message.dart';
import 'package:fluxer_fcm/fluxer_fcm_bootstrap.dart';

@pragma('vm:entry-point')
Future<void> fcmBackgroundMessageHandlerEntry(RemoteMessage message) async {
  _configureFcmBootstrap();
  await fcmBackgroundMessageHandler(message);
}

void _configureFcmBootstrap() {
  FluxerFcmBootstrap.configure(
    enrichTapPayload: FcmTapPayloadCache.enrich,
    shouldSaveTapPayloadCache: shouldSaveFcmTapPayloadCache,
    saveTapPayloadCache: FcmTapPayloadCache.save,
    onBackgroundNotificationTap: FcmPendingNotificationTap.save,
    cancelFcmSystemDuplicates:
        FcmAndroidSystemNotificationCancelBridge.cancelFcmSystemDuplicates,
    shouldDisplayBackgroundLocalNotification: _shouldDisplayBackgroundLocal,
  );
}

bool _shouldDisplayBackgroundLocal(FcmPushMessage message) {
  return shouldSaveFcmTapPayloadCache(message.payload);
}

Future<void> bootstrapFcmIfNeeded() async {
  if (!PushProviderGuard.isFirebaseMessaging || !Platform.isAndroid) {
    return;
  }
  try {
    _configureFcmBootstrap();
    await FluxerFcmBootstrap.bootstrapIfNeeded(
      onBackgroundMessage: fcmBackgroundMessageHandlerEntry,
    );
  } on Object catch (error, stackTrace) {
    if (kDebugMode) {
      debugPrint('[FCM] bootstrapIfNeeded failed: $error\n$stackTrace');
    }
    rethrow;
  }
}

Future<void> bootstrapFcmAfterRunApp() async {
  if (!PushProviderGuard.isFirebaseMessaging || !Platform.isAndroid) {
    return;
  }
  try {
    await FluxerFcmBootstrap.bootstrapAfterRunApp();
  } on Object catch (error, stackTrace) {
    if (kDebugMode) {
      debugPrint('[FCM] bootstrapAfterRunApp failed: $error\n$stackTrace');
    }
    rethrow;
  }
}
