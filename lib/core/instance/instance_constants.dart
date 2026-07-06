abstract final class InstanceConstants {
  static const int apiCodeVersion = 1;
  static const String defaultApiBaseUrl = 'https://echowire.org/api/v1';
  // Gateway for the official Echowire instance. The "official instance" path
  // skips discovery and uses officialDefault(), so this must be a real URL —
  // an empty gateway means the app can't connect after login.
  static const String defaultGatewayUrl = 'wss://echowire.org/gateway';
  static const String defaultInstanceInputUrl = 'echowire.org';
  static const int maxRecentInstances = 5;

  static const Set<String> officialInstanceHosts = <String>{
    'echowire.org',
    'www.echowire.org',
  };
}
