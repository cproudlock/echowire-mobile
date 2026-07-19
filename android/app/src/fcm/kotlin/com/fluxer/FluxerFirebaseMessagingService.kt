package com.fluxer

import android.content.Intent
import android.os.Bundle
import com.google.android.gms.cloudmessaging.CloudMessage
import com.google.android.gms.cloudmessaging.Rpc
import com.google.firebase.messaging.FirebaseMessagingService

class FluxerFirebaseMessagingService : FirebaseMessagingService() {
    override fun onNewToken(token: String) {
        io.flutter.plugins.firebase.messaging.FlutterFirebaseTokenLiveData
            .getInstance()
            .postToken(token)
    }

    override fun handleIntent(intent: Intent) {
        when (intent.action) {
            REMOTE_INTENT_ACTION,
            DIRECT_BOOT_REMOTE_INTENT_ACTION,
            -> handleRemoteMessageIntent(intent)
            else -> super.handleIntent(intent)
        }
    }

    private fun handleRemoteMessageIntent(intent: Intent) {
        val extras = intent.extras ?: return
        if (hasNotificationPayload(extras)) {
            // Fast path: hand the notification-carrying message to the base
            // FirebaseMessagingService so the Android system tray renders it
            // instantly (no Flutter background engine spin-up). When the app is
            // foregrounded the base class routes to onMessageReceived instead,
            // preserving in-app handling. The broadcast receiver still enqueues
            // the Dart background handler for data-side work (badge/dedupe/tap
            // cache); that handler skips display because notification != null,
            // so there is no duplicate.
            super.handleIntent(intent)
            return
        }
        val data = Bundle(extras)
        data.remove("androidx.content.wakelockid")
        FcmMessageForwarder.enrichNotificationIntoData(data)
        Rpc(applicationContext).messageHandled(CloudMessage(intent))
    }

    private fun hasNotificationPayload(extras: Bundle): Boolean =
        !extras.getString("gcm.notification.title").isNullOrBlank() ||
            !extras.getString("gcm.notification.body").isNullOrBlank()

    private companion object {
        const val REMOTE_INTENT_ACTION = "com.google.android.c2dm.intent.RECEIVE"
        const val DIRECT_BOOT_REMOTE_INTENT_ACTION =
            "com.google.firebase.messaging.RECEIVE_DIRECT_BOOT"
    }
}
