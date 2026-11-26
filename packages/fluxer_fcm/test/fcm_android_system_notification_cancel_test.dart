import 'package:flutter_test/flutter_test.dart';
import 'package:fluxer_fcm/fcm_android_system_notification_cancel.dart';
import 'package:fluxer_fcm/fcm_push_notification_ids.dart';

void main() {
  group('fcmJavaStringHashCode', () {
    test('matches Java String.hashCode for sample values', () {
      expect(fcmJavaStringHashCode(''), 0);
      expect(fcmJavaStringHashCode('a'), 97);
      expect(fcmJavaStringHashCode('msg-1'), 104190181);
    });
  });

  group('collectFcmCandidateMessageIds', () {
    test('collects gcm id and payload message_id', () {
      final Iterable<String> ids = collectFcmCandidateMessageIds(
        messageId: 'gcm-1',
        payload: <String, String>{'message_id': 'msg-9'},
      );
      expect(ids, containsAll(<String>['gcm-1', 'msg-9']));
    });
  });

  group('fcmSystemNotificationCancelIds', () {
    test('includes only java hash ids', () {
      const String messageId = 'msg-1';
      final Iterable<int> ids = fcmSystemNotificationCancelIds(<String>[
        messageId,
      ]);
      expect(ids, isNot(contains(fcmPushMessageNotificationId(messageId))));
      expect(ids, contains(fcmJavaStringHashCode(messageId)));
    });

    test('merges java hash ids from multiple candidates', () {
      const String gcmId = '0:123';
      const String dataId = 'msg-9';
      final Iterable<int> ids = fcmSystemNotificationCancelIds(<String>[
        gcmId,
        dataId,
      ]);
      expect(ids, contains(fcmJavaStringHashCode(gcmId)));
      expect(ids, contains(fcmJavaStringHashCode(dataId)));
    });

    test('returns empty for empty message ids', () {
      expect(fcmSystemNotificationCancelIds(<String>['']), isEmpty);
    });
  });

  group('fcmSystemNotificationTags', () {
    test('targets the server tag the system copy is posted under', () {
      final Iterable<String> tags = fcmSystemNotificationTags(
        payload: <String, String>{'tag': 'channel:1:2'},
        localNotificationId: 22164616,
        localTag: 'channel:1',
      );
      expect(tags, <String>['channel:1:2']);
    });

    test('is empty without a tag', () {
      expect(
        fcmSystemNotificationTags(
          payload: const <String, String>{},
          localNotificationId: 5,
          localTag: 'channel:1',
        ),
        isEmpty,
      );
    });

    test('never targets the local notification itself', () {
      expect(
        fcmSystemNotificationTags(
          payload: <String, String>{'tag': 'channel:1'},
          localNotificationId: kFcmSystemNotificationId,
          localTag: 'channel:1',
        ),
        isEmpty,
      );
    });
  });
}
