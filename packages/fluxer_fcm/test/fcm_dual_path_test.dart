import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fluxer_fcm/fcm_message_mapper.dart';
import 'package:fluxer_fcm/fcm_push_message.dart';

/// Echowire: upstream delivers notifications as encrypted web push only and
/// drops anything without the `p` ciphertext. This instance still sends
/// plaintext FCM payloads while the server relay is opt-in and disabled, so
/// both shapes have to survive the mapper.
///
/// Delete the plaintext half of these tests once the relay is enabled and
/// adopted, at the same time as the fallback in fcm_message_mapper.dart.
void main() {
  group('encrypted path', () {
    test('a ciphertext message carries only the envelope', () {
      final RemoteMessage input = RemoteMessage(
        messageId: 'encrypted-1',
        data: <String, String>{
          'v': '1',
          'p': 'Y2lwaGVydGV4dA==',
          'title': 'server-built',
          'body': 'should not be used',
        },
        notification: const RemoteNotification(
          title: 'server-built',
          body: 'should not be used',
        ),
      );

      final FcmPushMessage mapped = mapRemoteMessage(input);

      expect(mapped.id, 'encrypted-1');
      expect(mapped.payload, <String, String>{'p': 'Y2lwaGVydGV4dA=='});
      expect(
        mapped.title,
        isNull,
        reason: 'the title comes from the decrypted envelope, not the wire',
      );
      expect(mapped.body, isNull);
    });
  });

  group('plaintext fallback', () {
    test('a plaintext message keeps its title and body', () {
      final RemoteMessage input = RemoteMessage(
        messageId: 'plaintext-1',
        data: <String, String>{'channel_id': 'chan-7'},
        notification: const RemoteNotification(
          title: 'alice',
          body: 'hello there',
        ),
      );

      final FcmPushMessage mapped = mapRemoteMessage(input);

      expect(mapped.id, 'plaintext-1');
      expect(
        mapped.title,
        'alice',
        reason: 'upstream returns null here and the notification shows nothing',
      );
      expect(mapped.body, 'hello there');
      expect(mapped.payload['channel_id'], 'chan-7');
    });

    test('a plaintext message falls back to data title and body', () {
      final RemoteMessage input = RemoteMessage(
        messageId: 'plaintext-2',
        data: <String, String>{'title': 'bob', 'body': 'from data'},
      );

      final FcmPushMessage mapped = mapRemoteMessage(input);

      expect(mapped.title, 'bob');
      expect(mapped.body, 'from data');
    });

    test('a plaintext message with no text uses the echowire default', () {
      final RemoteMessage input = RemoteMessage(
        messageId: 'plaintext-3',
        data: <String, String>{'channel_id': 'chan-9'},
      );

      final FcmPushMessage mapped = mapRemoteMessage(input);

      expect(mapped.title, 'echowire');
      expect(mapped.title, isNot('Fluxer'));
      expect(mapped.body, 'New message');
    });

    test('a plaintext tap keeps the navigation payload', () {
      final RemoteMessage input = RemoteMessage(
        messageId: 'plaintext-4',
        data: <String, String>{
          'channel_id': 'chan-4',
          'guild_id': 'guild-4',
          'navigate': '/channels/guild-4/chan-4',
        },
      );

      final FcmPushMessage mapped = mapRemoteMessage(input);

      expect(
        mapped.payload['url'],
        '/channels/guild-4/chan-4',
        reason: 'without this a tapped notification lands nowhere',
      );
      expect(mapped.payload.containsKey('navigate'), isFalse);
      expect(mapped.payload['channel_id'], 'chan-4');
    });

    test('a plaintext message flattens a nested json data payload', () {
      final RemoteMessage input = RemoteMessage(
        messageId: 'plaintext-5',
        data: <String, String>{'data': '{"channel_id":"chan-5","url":"/go"}'},
      );

      final FcmPushMessage mapped = mapRemoteMessage(input);

      expect(mapped.payload['channel_id'], 'chan-5');
      expect(mapped.payload['url'], '/go');
      expect(mapped.payload.containsKey('data'), isFalse);
    });

    test('an empty ciphertext string is treated as plaintext', () {
      final RemoteMessage input = RemoteMessage(
        messageId: 'plaintext-6',
        data: <String, String>{'p': '', 'title': 'carol'},
      );

      expect(extractFcmCiphertext(input.data), isNull);
      expect(mapRemoteMessage(input).title, 'carol');
    });
  });
}
