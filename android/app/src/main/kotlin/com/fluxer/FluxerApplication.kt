package com.fluxer

import android.app.Application
import android.app.NotificationChannel
import android.app.NotificationManager
import android.media.AudioAttributes
import android.net.Uri
import android.content.pm.PackageManager
import android.os.Build
import sh.measure.android.Measure
import sh.measure.android.config.MeasureConfig

/**
 * Creates every push notification channel on each process start, before any FCM
 * message can be rendered.
 *
 * Android 8+ silently DROPS a notification-message targeting a channel that does
 * not exist yet, with nothing logged on the device or reported to the sender, so
 * the only safe arrangement is for the app to own every channel the server might
 * name. The Dart layers create channels too (LocalPushNotifications for the
 * per-type ones, fcm_background_local_notifications for the legacy one) but only
 * lazily: the former late in the app-startup/login sequence, the latter on the
 * first background notification. On a device where neither had run, the channel
 * was missing and every push was dropped. Application.onCreate runs on app
 * launch AND on any FCM-triggered process start, so creating them here
 * guarantees the system can render instantly with no app wake.
 *
 * Channel IDs MUST stay stable: Android keys the user's own sound, importance
 * and vibration choices to the ID, so a new ID silently resets their settings.
 * The sounds and names MUST match the Dart definitions in
 * lib/core/push/local_push_notifications.dart, because channel creation is
 * idempotent in the sense that the FIRST creation wins -- a later create with a
 * different sound is ignored, so a mismatch here could never be corrected by
 * Dart. The URI form matches flutter_local_notifications'
 * RawResourceAndroidNotificationSound ("android.resource://<pkg>/raw/<name>")
 * and the usage-only AudioAttributes it builds.
 *
 * fluxer_default_push is deliberately left without a sound, which is what every
 * already-installed client created, so its behaviour does not change under
 * existing users.
 */
class FluxerApplication : Application() {
    override fun onCreate() {
        super.onCreate()
        createNotificationChannels()
        // Echowire: upstream telemetry starts only when a build supplies the Measure key and
        // url. This fork supplies neither, so nothing is initialised or sent.
        if (measureConfigured()) {
            Measure.init(this, MeasureConfig())
        }
    }

    private fun measureConfigured(): Boolean {
        val meta =
            packageManager
                .getApplicationInfo(packageName, PackageManager.GET_META_DATA)
                .metaData
        val apiKey = meta?.getString("sh.measure.android.API_KEY")?.trim() ?: ""
        val apiUrl = meta?.getString("sh.measure.android.API_URL")?.trim() ?: ""
        return apiKey.isNotEmpty() && apiUrl.isNotEmpty()
    }

    private fun createNotificationChannels() {
        if (Build.VERSION.SDK_INT < Build.VERSION_CODES.O) {
            return
        }
        val manager = getSystemService(NotificationManager::class.java) ?: return
        manager.createNotificationChannel(channel(LEGACY_CHANNEL_ID, LEGACY_CHANNEL_NAME, null))
        manager.createNotificationChannel(
            channel(MESSAGE_CHANNEL_ID, MESSAGE_CHANNEL_NAME, MESSAGE_SOUND_RAW),
        )
        manager.createNotificationChannel(
            channel(
                DIRECT_MESSAGE_CHANNEL_ID,
                DIRECT_MESSAGE_CHANNEL_NAME,
                DIRECT_MESSAGE_SOUND_RAW,
            ),
        )
    }

    private fun channel(id: String, name: String, soundRaw: String?): NotificationChannel =
        NotificationChannel(id, name, NotificationManager.IMPORTANCE_HIGH).apply {
            description = CHANNEL_DESCRIPTION
            if (soundRaw != null) {
                setSound(
                    Uri.parse("android.resource://$packageName/raw/$soundRaw"),
                    AudioAttributes.Builder()
                        .setUsage(AudioAttributes.USAGE_NOTIFICATION)
                        .build(),
                )
            }
        }

    private companion object {
        const val LEGACY_CHANNEL_ID = "fluxer_default_push"
        const val LEGACY_CHANNEL_NAME = "echowire"
        const val MESSAGE_CHANNEL_ID = "fluxer_messages"
        const val MESSAGE_CHANNEL_NAME = "Messages"
        const val MESSAGE_SOUND_RAW = "message"
        const val DIRECT_MESSAGE_CHANNEL_ID = "fluxer_direct_messages"
        const val DIRECT_MESSAGE_CHANNEL_NAME = "Direct messages"
        const val DIRECT_MESSAGE_SOUND_RAW = "direct_message"
        const val CHANNEL_DESCRIPTION = "Messages and alerts"
    }
}
