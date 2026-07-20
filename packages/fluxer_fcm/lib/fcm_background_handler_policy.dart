import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:fluxer_fcm/fcm_background_display_hooks.dart';
import 'package:fluxer_fcm/fcm_push_message.dart';

bool shouldDisplayFcmBackgroundLocalNotification(
  RemoteMessage message,
  FcmPushMessage mapped,
) {
  if (FcmBackgroundDisplayHooks.shouldDisplayLocalNotification(mapped)) {
    return true;
  }
  // The app ships a custom FCM receiver (FluxerFirebaseMessagingReceiver) that
  // intercepts every message and suppresses the OS from rendering the
  // `notification` block itself. When the app is backgrounded or killed, this
  // Dart background handler is the ONLY code that can display the notification.
  // Previously this returned `message.notification == null`, which dropped every
  // notification+data push (the gateway's message pushes) — they silently never
  // appeared. Render them here instead. (Clear/silent messages carry no
  // notification block and are unchanged; they still return true and are handled
  // as before.)
  return true;
}
