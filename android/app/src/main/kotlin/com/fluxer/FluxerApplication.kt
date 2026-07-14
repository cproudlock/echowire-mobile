package com.fluxer

import android.app.Application
import android.app.NotificationChannel
import android.app.NotificationManager
import android.os.Build

/**
 * Creates the default push notification channel on every process start, before
 * any FCM message can be rendered.
 *
 * Android 8+ silently DROPS a notification-message targeting a channel that does
 * not exist yet. The Dart layer (LocalPushNotifications) also creates this
 * channel, but only late in the app-startup/login sequence, so on a device
 * where that had not run yet the channel was missing and every push was dropped.
 * Creating it here — in Application.onCreate, which runs on app launch AND on any
 * FCM-triggered process start — guarantees the channel exists so the system can
 * render notification messages instantly (no app wake needed).
 *
 * Channel id/name/importance MUST match LocalPushNotifications._channelId etc.
 * createNotificationChannel is idempotent and never overrides the user's own
 * per-channel settings.
 */
class FluxerApplication : Application() {
    override fun onCreate() {
        super.onCreate()
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            val channel = NotificationChannel(
                DEFAULT_PUSH_CHANNEL_ID,
                DEFAULT_PUSH_CHANNEL_NAME,
                NotificationManager.IMPORTANCE_HIGH,
            ).apply {
                description = DEFAULT_PUSH_CHANNEL_DESCRIPTION
            }
            getSystemService(NotificationManager::class.java)
                ?.createNotificationChannel(channel)
        }
    }

    private companion object {
        const val DEFAULT_PUSH_CHANNEL_ID = "fluxer_default_push"
        const val DEFAULT_PUSH_CHANNEL_NAME = "Echowire"
        const val DEFAULT_PUSH_CHANNEL_DESCRIPTION = "Messages and alerts"
    }
}
