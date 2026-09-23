import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:fluxer_fcm/fcm_message_mapper.dart';
import 'package:fluxer_fcm/fcm_push_message.dart';

class FluxerFcmPushService {
  factory FluxerFcmPushService() => instance;

  FluxerFcmPushService._();

  static final FluxerFcmPushService instance = FluxerFcmPushService._();

  final StreamController<FcmPushMessage> _messages =
      StreamController<FcmPushMessage>.broadcast();
  final StreamController<String> _ciphertext =
      StreamController<String>.broadcast();
  final StreamController<String> _tokenRefresh =
      StreamController<String>.broadcast();

  bool _initialized = false;
  void Function(Map<String, String> payload)? _onNotificationTap;
  Map<String, String>? _pendingNotificationTapPayload;
  StreamSubscription<RemoteMessage>? _onMessageSubscription;
  StreamSubscription<RemoteMessage>? _onMessageOpenedAppSubscription;
  StreamSubscription<String>? _onTokenRefreshSubscription;

  bool Function(FcmPushMessage message)? _foregroundMessageFilter;

  Stream<String> get tokenRefreshStream => _tokenRefresh.stream;

  void setForegroundMessageFilter(
    bool Function(FcmPushMessage message)? filter,
  ) {
    _foregroundMessageFilter = filter;
  }

  @visibleForTesting
  bool Function(FcmPushMessage message)?
  get foregroundMessageFilterForTesting => _foregroundMessageFilter;

  @visibleForTesting
  bool shouldProcessForegroundMessage(FcmPushMessage message) {
    final bool Function(FcmPushMessage message)? filter =
        _foregroundMessageFilter;
    if (filter == null) {
      return true;
    }
    return filter(message);
  }

  void setNotificationTapCallback(
    void Function(Map<String, String> payload)? callback,
  ) {
    _onNotificationTap = callback;
    if (callback == null) {
      return;
    }
    final Map<String, String>? pendingPayload = _pendingNotificationTapPayload;
    if (pendingPayload == null) {
      return;
    }
    _pendingNotificationTapPayload = null;
    callback(pendingPayload);
  }

  Future<void> requestPermissions() async {
    final NotificationSettings settings = await FirebaseMessaging.instance
        .requestPermission();
    if (kDebugMode) {
      debugPrint(
        '[FluxerFcmPushService] permission: ${settings.authorizationStatus}',
      );
    }
  }

  Future<void> initialize({FirebaseOptions? firebaseOptions}) async {
    if (_initialized) {
      return;
    }
    if (Firebase.apps.isEmpty) {
      await Firebase.initializeApp(options: firebaseOptions);
    }
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
          alert: true,
          badge: true,
          sound: true,
        );
    _onMessageSubscription = FirebaseMessaging.onMessage.listen(
      _onForegroundMessage,
    );
    _onMessageOpenedAppSubscription = FirebaseMessaging.onMessageOpenedApp
        .listen(_onMessageOpenedApp);
    _onTokenRefreshSubscription = FirebaseMessaging.instance.onTokenRefresh
        .listen((String token) {
          if (token.isNotEmpty) {
            _tokenRefresh.add(token);
          }
        });
    final RemoteMessage? initialMessage = await FirebaseMessaging.instance
        .getInitialMessage();
    if (initialMessage != null) {
      if (kDebugMode) {
        debugPrint(
          '[FluxerFcmPushService] getInitialMessage '
          'id=${initialMessage.messageId} data=${initialMessage.data}',
        );
      }
      _dispatchTap(initialMessage);
    }
    _initialized = true;
    if (kDebugMode) {
      debugPrint('[FluxerFcmPushService] initialized');
    }
  }

  Future<String?> getToken() async {
    return FirebaseMessaging.instance.getToken();
  }

  /// Echowire: enriches a plaintext tap payload from the cache before it is
  /// dispatched. Upstream removed this with the plaintext stack; without it a
  /// tapped notification loses its cached navigation context.
  Future<Map<String, String>> Function(
    RemoteMessage message,
    Map<String, String> mappedPayload,
  )?
  tapPayloadEnricher;

  Stream<FcmPushMessage> watchMessages() => _messages.stream;

  Stream<String> watchCiphertext() => _ciphertext.stream;

  void _onForegroundMessage(RemoteMessage message) {
    final String? ciphertext = extractFcmCiphertext(message.data);
    if (ciphertext != null) {
      if (kDebugMode) {
        debugPrint('[FluxerFcmPushService] foreground ciphertext');
      }
      _ciphertext.add(ciphertext);
      return;
    }
    // Echowire: plaintext fallback while the server relay is disabled.
    // Upstream returns here and the notification is silently dropped.
    if (kDebugMode) {
      debugPrint('[FluxerFcmPushService] foreground plaintext');
    }
    _messages.add(mapRemoteMessage(message));
  }

  void _onMessageOpenedApp(RemoteMessage message) {
    if (kDebugMode) {
      debugPrint(
        '[FluxerFcmPushService] onMessageOpenedApp '
        'id=${message.messageId} data=${message.data}',
      );
    }
    _dispatchTap(message);
  }

  void _dispatchTap(RemoteMessage message) {
    final String? ciphertext = extractFcmCiphertext(message.data);
    if (ciphertext != null) {
      if (kDebugMode) {
        debugPrint('[FluxerFcmPushService] tap ciphertext');
      }
      _dispatchTapPayload(<String, String>{'p': ciphertext});
      return;
    }
    // Echowire: a plaintext tap still has to carry its navigation payload,
    // enriched from the cache, otherwise opening it lands nowhere.
    unawaited(_dispatchPlaintextTap(message));
  }

  Future<void> _dispatchPlaintextTap(RemoteMessage message) async {
    Map<String, String> payload = mapRemoteMessage(message).payload;
    final Future<Map<String, String>> Function(
      RemoteMessage message,
      Map<String, String> mappedPayload,
    )?
    enricher = tapPayloadEnricher;
    if (enricher != null) {
      payload = await enricher(message, payload);
    }
    if (kDebugMode) {
      debugPrint('[FluxerFcmPushService] tap plaintext payload=$payload');
    }
    _dispatchTapPayload(payload);
  }

  void _dispatchTapPayload(Map<String, String> payload) {
    final void Function(Map<String, String> payload)? callback =
        _onNotificationTap;
    if (callback != null) {
      callback(payload);
      return;
    }
    _pendingNotificationTapPayload = Map<String, String>.unmodifiable(payload);
  }

  @visibleForTesting
  void dispatchTapPayloadForTesting(Map<String, String> payload) {
    _dispatchTapPayload(payload);
  }

  @visibleForTesting
  void resetForTesting() {
    _initialized = false;
    _onNotificationTap = null;
    _pendingNotificationTapPayload = null;
    unawaited(_onMessageSubscription?.cancel());
    unawaited(_onMessageOpenedAppSubscription?.cancel());
    unawaited(_onTokenRefreshSubscription?.cancel());
    _onMessageSubscription = null;
    _onMessageOpenedAppSubscription = null;
    _onTokenRefreshSubscription = null;
    _foregroundMessageFilter = null;
  }
}
