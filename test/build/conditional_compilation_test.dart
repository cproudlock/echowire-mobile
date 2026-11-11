import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:fluxer_app/core/build/app_build_config.dart';
import 'package:fluxer_app/core/build/push_provider_kind.dart';

void main() {
  final Directory projectRoot = _findProjectRoot(Directory.current);

  group('conditional compilation artifacts', () {
    test('main manifest excludes firebase metadata', () {
      final File manifest = File(
        '${projectRoot.path}/android/app/src/main/AndroidManifest.xml',
      );
      final String content = manifest.readAsStringSync();
      expect(content, isNot(contains('com.google.firebase.messaging')));
    });

    test('fcm flavor manifest declares firebase messaging service', () {
      final File manifest = File(
        '${projectRoot.path}/android/app/src/fcm/AndroidManifest.xml',
      );
      final String content = manifest.readAsStringSync();
      expect(content, contains('FluxerFirebaseMessagingService'));
      expect(content, contains('FluxerFirebaseMessagingReceiver'));
      expect(content, contains('com.google.firebase.MESSAGING_EVENT'));
      expect(content, contains('com.google.android.c2dm.intent.RECEIVE'));
      expect(content, contains('tools:node="remove"'));
      expect(
        content,
        contains(
          'io.flutter.plugins.firebase.messaging.FlutterFirebaseMessagingReceiver',
        ),
      );
      expect(
        content,
        contains('com.google.firebase.messaging.default_notification_icon'),
      );
      expect(
        content,
        contains(
          'com.google.android.datatransport.runtime.scheduling.jobscheduling.AlarmManagerSchedulerBroadcastReceiver',
        ),
      );
    });

    test('main manifest excludes play billing queries', () {
      final File manifest = File(
        '${projectRoot.path}/android/app/src/main/AndroidManifest.xml',
      );
      final String content = manifest.readAsStringSync();
      expect(
        content,
        isNot(contains('com.android.vending.billing.InAppBillingService.BIND')),
      );
    });
  });

  group('echowire fcm templates', () {
    // Echowire: the android-fcm profile copies these over the active push sources. Upstream's
    // versions of the same files decode relay ciphertext (AndroidPushPipeline), which this fork's
    // server never sends, so a merge that takes upstream's template ships an app with no push.
    const Map<String, List<String>> templates = <String, List<String>>{
      'lib/core/push/services/firebase_messaging_push_service.fcm.dart':
          <String>['watchMessages', 'FcmPushMessage'],
      'lib/core/push/fcm/fcm_entrypoint.fcm.dart': <String>[
        'FluxerFcmBootstrap.configure',
        'FcmTapPayloadCache',
      ],
    };

    templates.forEach((String path, List<String> required) {
      test('$path keeps the raw-FCM implementation', () {
        final String source = File(
          '${projectRoot.path}/$path',
        ).readAsStringSync();
        expect(
          source,
          isNot(contains('AndroidPushPipeline')),
          reason: 'upstream relay-ciphertext template would drop echowire push',
        );
        for (final String needle in required) {
          expect(source, contains(needle), reason: '$path lost $needle');
        }
      });
    });
  });

  group('runtime push provider guard', () {
    test('defaults to apple push provider outside FCM builds', () {
      expect(AppBuildConfig.pushProvider, PushProviderKind.apple);
    });
  });
}

Directory _findProjectRoot(Directory start) {
  Directory? current = start;
  while (current != null) {
    if (File('${current.path}/pubspec.yaml').existsSync()) {
      return current;
    }
    current = current.parent;
  }
  throw StateError('Could not find project root (pubspec.yaml)');
}
