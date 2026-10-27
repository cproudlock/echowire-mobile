import 'package:fluxer_app/core/push/notification/path_resolver.dart';
import 'package:fluxer_app/core/push/notification/payload.dart';

bool shouldSaveFcmTapPayloadCache(Map<String, String> payload) {
  final Map<String, String> normalized = normalizePushTapPayload(payload);
  return resolvePushNotificationPath(normalized) != null;
}
