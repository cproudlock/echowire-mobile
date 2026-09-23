import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fluxer_fcm/fcm_message_mapper.dart';
import 'package:fluxer_fcm/fcm_push_message.dart';

void main() {
  group('extractFcmCiphertext', () {
    test('reads the data-only ciphertext field', () {
      final RemoteMessage input = RemoteMessage(
        messageId: 'msg-1',
        data: <String, String>{'v': '1', 'p': 'abc'},
        notification: const RemoteNotification(title: 'alice', body: 'hello'),
      );
      expect(extractFcmCiphertext(input.data), 'abc');
      final FcmPushMessage message = mapRemoteMessage(input);
      expect(message.payload['p'], 'abc');
      expect(message.title, isNull);
      expect(message.body, isNull);
    });

    // Echowire: upstream maps a message without ciphertext to an empty
    // payload, which shows nothing. This instance still sends plaintext while
    // the server relay is disabled, so the mapper falls back instead of
    // dropping. See fcm_dual_path_test.dart.
    test('falls back to plaintext when there is no ciphertext', () {
      final RemoteMessage input = RemoteMessage(
        data: <String, String>{'title': 'from-data', 'body': 'body-data'},
      );
      expect(extractFcmCiphertext(input.data), isNull);
      final FcmPushMessage message = mapRemoteMessage(input);
      expect(message.title, 'from-data');
      expect(message.body, 'body-data');
    });
  });
}
