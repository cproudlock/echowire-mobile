import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:fluxer_fcm/fcm_push_message.dart';

const String kFcmDefaultTitle = 'echowire';

String? extractFcmCiphertext(Map<String, dynamic> data) {
  final Object? value = data['p'];
  if (value is! String || value.isEmpty) {
    return null;
  }
  return value;
}

/// Echowire: upstream delivers notifications as encrypted web push only, and
/// drops anything without the `p` ciphertext. This instance still sends
/// plaintext FCM payloads because the server relay is opt-in and disabled, so
/// both shapes have to work. Encrypted messages take upstream's path; anything
/// else falls back to the fork's plaintext display, tap and clear stack.
///
/// Delete the plaintext half once the relay is enabled and adopted.
FcmPushMessage mapRemoteMessage(RemoteMessage message) {
  final String? ciphertext = extractFcmCiphertext(message.data);
  if (ciphertext != null) {
    final String? messageId = message.messageId;
    final String id = messageId != null && messageId.isNotEmpty
        ? messageId
        : DateTime.now().microsecondsSinceEpoch.toString();
    return FcmPushMessage(
      id: id,
      title: null,
      body: null,
      payload: <String, String>{'p': ciphertext},
    );
  }
  return _mapPlaintextMessage(message);
}

FcmPushMessage _mapPlaintextMessage(RemoteMessage message) {
  final Map<String, String> dataPayload = _buildNavigationPayload(message.data);
  final RemoteNotification? notification = message.notification;
  final String? title = notification?.title ?? dataPayload['title'];
  final String? body = notification?.body ?? dataPayload['body'];
  final String id = _resolveMessageId(message, dataPayload);
  return FcmPushMessage(
    id: id,
    title: title ?? kFcmDefaultTitle,
    body: body ?? 'New message',
    payload: dataPayload,
  );
}

String _resolveMessageId(
  RemoteMessage message,
  Map<String, String> dataPayload,
) {
  final String? messageId = message.messageId;
  if (messageId != null && messageId.isNotEmpty) {
    return messageId;
  }
  final String? dataId = dataPayload['message_id'] ?? dataPayload['id'];
  if (dataId != null && dataId.isNotEmpty) {
    return dataId;
  }
  return DateTime.now().microsecondsSinceEpoch.toString();
}

Map<String, String> _buildNavigationPayload(Map<String, dynamic> source) {
  final Map<String, String> payload = _stringifyMap(source);
  final Map<String, String> nested = _readNestedDataPayload(source['data']);
  for (final MapEntry<String, String> entry in nested.entries) {
    payload.putIfAbsent(entry.key, () => entry.value);
  }
  final String? url =
      nested['url'] ??
      nested['navigate'] ??
      payload['url'] ??
      payload['navigate'];
  if (url != null && url.isNotEmpty) {
    payload['url'] = url;
  }
  payload.remove('navigate');
  payload.remove('data');
  return payload;
}

Map<String, String> _readNestedDataPayload(Object? rawData) {
  if (rawData == null) {
    return <String, String>{};
  }
  if (rawData is Map) {
    return _stringifyMap(Map<String, dynamic>.from(rawData));
  }
  if (rawData is String && rawData.isNotEmpty) {
    final Object? decoded = _tryJsonDecode(rawData);
    if (decoded is Map) {
      return _stringifyMap(Map<String, dynamic>.from(decoded));
    }
  }
  return <String, String>{};
}

Object? _tryJsonDecode(String raw) {
  try {
    return jsonDecode(raw);
  } on FormatException {
    return null;
  }
}

Map<String, String> _stringifyMap(Map<String, dynamic> source) {
  final Map<String, String> result = <String, String>{};
  for (final MapEntry<String, dynamic> entry in source.entries) {
    if (entry.key == 'data') {
      continue;
    }
    final dynamic value = entry.value;
    if (value == null) {
      continue;
    }
    if (value is Map || value is List) {
      result[entry.key] = jsonEncode(value);
    } else {
      result[entry.key] = value.toString();
    }
  }
  return result;
}
