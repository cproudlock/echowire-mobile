abstract final class InstanceConstants {
  static const int apiCodeVersion = 1;
  static const String defaultApiBaseUrl = 'https://echowire.org/api/v1';
  // Gateway for the official Echowire instance. The "official instance" path
  // skips discovery and uses officialDefault(), so this must be a real URL;
  // an empty gateway means the app cannot connect after login.
  static const String defaultGatewayUrl = 'wss://echowire.org/gateway';
  static const String defaultInstanceInputUrl = 'echowire.org';
  // Echowire: upstream #931d1d3c added these for its canary instance and
  // InstanceLegacyEndpointMigrator references them, so they must exist. This
  // fork runs no canary instance and officialInstanceHosts carries no
  // "canary." host, so _targetsFor never takes that branch; they point at our
  // own origin so a future canary cannot leak upstream hosts into a rewrite.
  static const String canaryApiBaseUrl = 'https://echowire.org/api/v1';
  static const String canaryInstanceInputUrl = 'echowire.org';
  static const String defaultMarketingBaseUrl = 'https://echowire.org';
  static const String defaultProductName = 'echowire';
  // Echowire: upstream defaults this to its own premium name; the fallback shown before an
  // instance reports its branding is ours.
  static const String defaultPremiumProductName = 'Reverb';
  static const int maxRecentInstances = 5;

  static const Set<String> officialInstanceHosts = <String>{
    'echowire.org',
    'www.echowire.org',
  };
}
