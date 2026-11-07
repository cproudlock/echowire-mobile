import 'package:passkeys/exceptions.dart';

const String kPasskeyMigrationRpId = 'fluxer.com';

// Echowire: fluxer.com passkeys belong to upstream's service. Our server issues
// challenges for echowire.org, and asking Android for an rpId this app is not
// associated with fails with a domain error that the fallback below does not
// catch. So never ask for the migration rpId.
String? preferredPasskeyRpId(String apiBaseUrl) => null;

Future<T> withPasskeyRelyingParty<T>({
  required String apiBaseUrl,
  required Future<T> Function(String? rpId) attempt,
}) async {
  final String? rpId = preferredPasskeyRpId(apiBaseUrl);
  if (rpId == null) {
    return attempt(null);
  }
  try {
    return await attempt(rpId);
  } on NoCredentialsAvailableException {
    return attempt(null);
  }
}
