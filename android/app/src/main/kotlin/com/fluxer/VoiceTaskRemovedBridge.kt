package com.fluxer

import android.content.Context
import android.os.Handler
import android.os.Looper
import com.hiennv.flutter_callkit_incoming.CallkitNotificationService
import com.hiennv.flutter_callkit_incoming.FlutterCallkitIncomingPlugin
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

private const val CHANNEL_NAME = "fluxer_app/voice_task_removed"
private const val METHOD_NOTIFY_TASK_REMOVED = "notifyTaskRemoved"
private const val NATIVE_CLEANUP_FALLBACK_MS = 500L

internal const val VOICE_TASK_REMOVED_CHANNEL_NAME = CHANNEL_NAME
internal const val VOICE_TASK_REMOVED_NOTIFY_METHOD = METHOD_NOTIFY_TASK_REMOVED

internal fun endActiveCallKitSessionsForAppTaskRemoved(context: Context) {
    try {
        FlutterCallkitIncomingPlugin.getInstance()?.endAllCalls()
    } catch (_: Throwable) {
    }
    try {
        CallkitNotificationService.stopService(context)
    } catch (_: Throwable) {
    }
}

class VoiceTaskRemovedBridge(
    private val context: Context,
) {
    private var methodChannel: MethodChannel? = null
    private val mainHandler = Handler(Looper.getMainLooper())

    fun register(flutterEngine: FlutterEngine) {
        methodChannel =
            MethodChannel(
                flutterEngine.dartExecutor.binaryMessenger,
                CHANNEL_NAME,
            )
    }

    fun onAppTaskRemoved() {
        val channel = methodChannel
        val appContext = context.applicationContext
        if (channel == null) {
            endActiveCallKitSessionsForAppTaskRemoved(appContext)
            return
        }
        var cleanedUp = false
        fun runNativeCleanupOnce() {
            if (cleanedUp) {
                return
            }
            cleanedUp = true
            endActiveCallKitSessionsForAppTaskRemoved(appContext)
        }
        val fallback = Runnable { runNativeCleanupOnce() }
        mainHandler.postDelayed(fallback, NATIVE_CLEANUP_FALLBACK_MS)
        channel.invokeMethod(
            METHOD_NOTIFY_TASK_REMOVED,
            null,
            object : MethodChannel.Result {
                override fun success(result: Any?) {
                    mainHandler.removeCallbacks(fallback)
                    runNativeCleanupOnce()
                }

                override fun error(
                    errorCode: String,
                    errorMessage: String?,
                    errorDetails: Any?,
                ) {
                    mainHandler.removeCallbacks(fallback)
                    runNativeCleanupOnce()
                }

                override fun notImplemented() {
                    mainHandler.removeCallbacks(fallback)
                    runNativeCleanupOnce()
                }
            },
        )
    }
}
