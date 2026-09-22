import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:fluxer_app/core/build/app_build_config.dart';
import 'package:fluxer_app/core/build/push_provider_kind.dart';

void main() {
  final Directory projectRoot = _findProjectRoot(Directory.current);

  group('conditional compilation artifacts', () {
    // Echowire inverts upstream's arrangement. Upstream commits the OSS stub
    // as the active source and swaps Firebase in for FCM builds; this fork
    // ships FCM and commits Firebase as the active source, with
    // tool/strip_firebase_deps.dart producing the stub state for an OSS or
    // UnifiedPush build. These tests therefore assert that inversion, and that
    // the tool has firebase-free sources to put in place, since nothing else
    // checks that an OSS build could not link Firebase.
    test('active push sources link firebase, not the stubs', () {
      // Not byte equality with the .fcm templates: the active entrypoint
      // legitimately differs from its template. What must hold is that the
      // committed sources are the Firebase-linked ones, so a strip that was
      // committed by accident fails here.
      for (final List<String> pair in <List<String>>[
        <String>[
          'lib/core/push/services/firebase_messaging_push_service.dart',
          'lib/core/push/services/firebase_messaging_push_service.stub.dart',
        ],
        <String>[
          'lib/core/push/fcm/fcm_entrypoint.dart',
          'lib/core/push/fcm/fcm_entrypoint_stub.dart',
        ],
      ]) {
        final File active = File('${projectRoot.path}/${pair[0]}');
        final File stub = File('${projectRoot.path}/${pair[1]}');
        expect(active.existsSync(), isTrue, reason: pair[0]);
        expect(stub.existsSync(), isTrue, reason: pair[1]);
        final String activeContent = active.readAsStringSync();
        expect(activeContent, contains('fluxer_fcm'), reason: pair[0]);
        expect(
          activeContent,
          isNot(stub.readAsStringSync()),
          reason: '${pair[0]} is the stub, so an OSS strip was committed',
        );
      }
    });

    test('stub sources exist, differ from the FCM variants, and link no '
        'firebase', () {
      for (final List<String> pair in <List<String>>[
        <String>[
          'lib/core/push/services/firebase_messaging_push_service.stub.dart',
          'lib/core/push/services/firebase_messaging_push_service.fcm.dart',
        ],
        <String>[
          'lib/core/push/fcm/fcm_entrypoint_stub.dart',
          'lib/core/push/fcm/fcm_entrypoint.fcm.dart',
        ],
      ]) {
        final File stub = File('${projectRoot.path}/${pair[0]}');
        final File template = File('${projectRoot.path}/${pair[1]}');
        expect(stub.existsSync(), isTrue, reason: pair[0]);
        final String stubContent = stub.readAsStringSync();
        expect(
          stubContent,
          isNot(template.readAsStringSync()),
          reason: '${pair[0]} must not be a copy of the FCM variant',
        );
        expect(stubContent, isNot(contains('fluxer_fcm')), reason: pair[0]);
        expect(stubContent, isNot(contains('firebase_')), reason: pair[0]);
      }
    });

    test('strip_firebase_deps targets exactly those stubs and sources', () {
      // Read the tool's own paths rather than restating them, so this cannot
      // drift from what the tool actually writes. Running the tool is not an
      // option here: it mutates tracked files in place.
      final String tool = File(
        '${projectRoot.path}/tool/strip_firebase_deps.dart',
      ).readAsStringSync();
      for (final String path in <String>[
        'lib/core/push/services/firebase_messaging_push_service.dart',
        'lib/core/push/services/firebase_messaging_push_service.stub.dart',
        'lib/core/push/fcm/fcm_entrypoint.dart',
        'lib/core/push/fcm/fcm_entrypoint_stub.dart',
      ]) {
        expect(tool, contains(path), reason: 'tool must handle $path');
      }
      expect(tool, contains('# BEGIN firebase optional deps'));
      expect(tool, contains('# END firebase optional deps'));
    });

    test('fcm template sources include firebase integration', () {
      final File serviceTemplate = File(
        '${projectRoot.path}/lib/core/push/services/firebase_messaging_push_service.fcm.dart',
      );
      final File entrypointTemplate = File(
        '${projectRoot.path}/lib/core/push/fcm/fcm_entrypoint.fcm.dart',
      );
      expect(serviceTemplate.readAsStringSync(), contains('fluxer_fcm'));
      expect(entrypointTemplate.readAsStringSync(), contains('fluxer_fcm'));
    });

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
    });

    test(
      'pubspec keeps the firebase deps inside the block the tool strips',
      () {
        final File pubspec = File('${projectRoot.path}/pubspec.yaml');
        final String content = pubspec.readAsStringSync();
        final int start = content.indexOf('# BEGIN firebase optional deps');
        final int end = content.indexOf('# END firebase optional deps');
        expect(start, greaterThanOrEqualTo(0), reason: 'missing BEGIN marker');
        expect(
          end,
          greaterThan(start),
          reason: 'missing or misplaced END marker',
        );
        // Every firebase dependency must sit inside the delimited block, or
        // strip_firebase_deps would leave one behind in an OSS build.
        final String block = content.substring(start, end);
        for (final String dep in <String>[
          'firebase_core:',
          'firebase_messaging:',
          'fluxer_fcm:',
        ]) {
          expect(content, contains(dep), reason: '$dep should be declared');
          expect(block, contains(dep), reason: '$dep must be inside the block');
        }
      },
    );
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
