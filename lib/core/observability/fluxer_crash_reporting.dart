import 'dart:async';

import 'package:fluxer_app/core/build/app_build_config.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

/// Crash/error reporting to the self-hosted GlitchTip (Sentry-protocol) instance
/// at glitchtip.echowire.org (project `echowire-mobile`, all flavors — filtered
/// by `environment`). Disabled unless a `SENTRY_DSN` is provided at build time.
///
/// Native crashes/ANRs are captured by the Sentry native SDKs once [initialize]
/// runs; Dart/Flutter errors are forwarded here from the central error sink
/// (`FluxerObservability.recordError`) via [captureError], so we do not depend on
/// wrapping `runApp` in Sentry's zone.
final class FluxerCrashReporting {
  FluxerCrashReporting._();

  static bool _initialized = false;

  static Future<void> initialize() async {
    if (_initialized || !AppBuildConfig.hasCrashReporting) {
      return;
    }
    _initialized = true;
    await SentryFlutter.init((SentryFlutterOptions options) {
      options
        ..dsn = AppBuildConfig.sentryDsn
        ..environment = AppBuildConfig.environmentName
        // Release/dist are auto-detected from the native build (build-name+number).
        ..sendDefaultPii = false
        // Crash/error reporting only — no performance tracing (GlitchTip's trace
        // support is limited, and OpenTelemetry tracing is handled separately).
        ..tracesSampleRate = 0.0;
    });
  }

  static void captureError(
    Object error, {
    StackTrace? stackTrace,
    String? source,
    String? context,
  }) {
    if (!_initialized || !AppBuildConfig.hasCrashReporting) {
      return;
    }
    unawaited(
      Sentry.captureException(
        error,
        stackTrace: stackTrace,
        withScope: (Scope scope) async {
          if (source != null && source.trim().isNotEmpty) {
            await scope.setTag('source', source.trim());
          }
          if (context != null && context.trim().isNotEmpty) {
            await scope.setContexts('flutter_error', <String, String>{
              'context': context.trim(),
            });
          }
        },
      ),
    );
  }
}
