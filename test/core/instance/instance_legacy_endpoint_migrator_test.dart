import 'package:flutter_test/flutter_test.dart';
import 'package:fluxer_app/core/instance/instance_config_snapshot.dart';
import 'package:fluxer_app/core/instance/instance_constants.dart';
import 'package:fluxer_app/core/instance/instance_legacy_endpoint_migrator.dart';

// Echowire: upstream added this suite alongside its own domain move, so every
// case fed an upstream host and expected an upstream target. The migrator keys
// entirely off InstanceConstants.officialInstanceHosts, which this fork narrows
// to echowire.org, so those inputs are not official here and the migrator
// correctly declines them. The cases below exercise the same code paths with
// this instance's own hosts: api.echowire.org and www.echowire.org are official
// but not canonical, so they are what a rewrite actually fires on.
void main() {
  const InstanceLegacyEndpointMigrator migrator =
      InstanceLegacyEndpointMigrator();

  group('migrateOfficialSnapshotIfNeeded', () {
    test('rewrites legacy api subdomain snapshot', () {
      const InstanceConfigSnapshot legacy = InstanceConfigSnapshot(
        apiBaseUrl: 'https://api.echowire.org/v1',
        gatewayUrl: 'wss://api.echowire.org/gateway',
        displayDomain: 'www.echowire.org',
      );
      final InstanceConfigSnapshot? migrated = migrator
          .migrateOfficialSnapshotIfNeeded(legacy);
      expect(migrated, isNotNull);
      expect(migrated!.apiBaseUrl, InstanceConstants.defaultApiBaseUrl);
      expect(migrated.gatewayUrl, InstanceConstants.defaultGatewayUrl);
      expect(migrated.displayDomain, InstanceConstants.defaultInstanceInputUrl);
      expect(migrated.wellKnown, isNull);
    });

    test('rewrites an upstream snapshot to this instance, never upstream', () {
      const InstanceConfigSnapshot upstreamCanary = InstanceConfigSnapshot(
        apiBaseUrl: 'https://api.canary.fluxer.app/v1',
        gatewayUrl: 'wss://gateway.canary.fluxer.app',
        displayDomain: 'canary.fluxer.app',
      );
      // _isLegacyGatewayUrl still matches upstream's hardcoded gateway hosts,
      // so this snapshot counts as official and is rewritten. The fork
      // requirement is only that the target is ours.
      final InstanceConfigSnapshot? migrated = migrator
          .migrateOfficialSnapshotIfNeeded(upstreamCanary);
      expect(migrated, isNotNull);
      expect(migrated!.apiBaseUrl, InstanceConstants.defaultApiBaseUrl);
      expect(migrated.gatewayUrl, InstanceConstants.defaultGatewayUrl);
      expect(
        migrated.apiBaseUrl,
        isNot(contains('fluxer.')),
        reason: 'a rewrite must never target upstream',
      );
      expect(migrated.gatewayUrl, isNot(contains('fluxer.')));
      expect(migrated.displayDomain, isNot(contains('fluxer.')));
    });

    test(
      'rewrites legacy api host even when display domain is not official',
      () {
        const InstanceConfigSnapshot legacy = InstanceConfigSnapshot(
          apiBaseUrl: 'https://api.echowire.org/v1',
          gatewayUrl: '',
          displayDomain: 'api.echowire.org',
        );
        final InstanceConfigSnapshot? migrated = migrator
            .migrateOfficialSnapshotIfNeeded(legacy);
        expect(migrated, isNotNull);
        expect(migrated!.apiBaseUrl, InstanceConstants.defaultApiBaseUrl);
      },
    );

    test('leaves self-hosted snapshots unchanged', () {
      const InstanceConfigSnapshot selfHosted = InstanceConfigSnapshot(
        apiBaseUrl: 'https://chat.example.com/v1',
        gatewayUrl: 'wss://chat.example.com/gateway',
        displayDomain: 'chat.example.com',
      );
      expect(migrator.migrateOfficialSnapshotIfNeeded(selfHosted), isNull);
    });

    test('leaves already-migrated official snapshot unchanged', () {
      final InstanceConfigSnapshot current =
          InstanceConfigSnapshot.officialDefault();
      expect(migrator.migrateOfficialSnapshotIfNeeded(current), isNull);
    });
  });

  group('migrateOfficialApiBaseUrlIfNeeded', () {
    test('rewrites legacy secure-storage api base url', () {
      expect(
        migrator.migrateOfficialApiBaseUrlIfNeeded(
          'https://api.echowire.org/v1',
        ),
        InstanceConstants.defaultApiBaseUrl,
      );
    });

    test('ignores current api base url', () {
      expect(
        migrator.migrateOfficialApiBaseUrlIfNeeded(
          InstanceConstants.defaultApiBaseUrl,
        ),
        isNull,
      );
    });

    test('ignores an upstream api host', () {
      expect(
        migrator.migrateOfficialApiBaseUrlIfNeeded('https://api.fluxer.app/v1'),
        isNull,
      );
    });
  });

  group('migrateOfficialRecentDomainIfNeeded', () {
    test('maps a non-canonical official host to the canonical one', () {
      expect(
        migrator.migrateOfficialRecentDomainIfNeeded('www.echowire.org'),
        InstanceConstants.defaultInstanceInputUrl,
      );
    });

    test('ignores self-hosted domains', () {
      expect(
        migrator.migrateOfficialRecentDomainIfNeeded('chat.example.com'),
        isNull,
      );
    });

    test('ignores upstream domains', () {
      expect(
        migrator.migrateOfficialRecentDomainIfNeeded('fluxer.app'),
        isNull,
      );
      expect(
        migrator.migrateOfficialRecentDomainIfNeeded('fluxer.com'),
        isNull,
      );
    });
  });

  // These guard the fork divergence itself. The migrator rewrites stored
  // endpoints on startup, so an upstream host reaching InstanceConstants would
  // silently repoint existing installs at upstream's servers.
  group('echowire endpoint guards', () {
    test('no upstream host appears in InstanceConstants', () {
      final List<String> values = <String>[
        InstanceConstants.defaultApiBaseUrl,
        InstanceConstants.defaultGatewayUrl,
        InstanceConstants.defaultInstanceInputUrl,
        InstanceConstants.canaryApiBaseUrl,
        InstanceConstants.canaryInstanceInputUrl,
        InstanceConstants.defaultMarketingBaseUrl,
        ...InstanceConstants.officialInstanceHosts,
      ];
      for (final String value in values) {
        expect(
          value.toLowerCase(),
          isNot(contains('fluxer.')),
          reason: 'upstream host leaked into InstanceConstants: $value',
        );
      }
    });

    test('official hosts are this instance only', () {
      expect(InstanceConstants.officialInstanceHosts, <String>{
        'echowire.org',
        'www.echowire.org',
      });
    });

    test('the canary target branch is unreachable on this instance', () {
      expect(
        InstanceConstants.officialInstanceHosts.any(
          (String host) => host.startsWith('canary.'),
        ),
        isFalse,
        reason:
            'a canary official host would route rewrites through the canary '
            'branch of _targetsFor',
      );
    });

    test('product name stays lowercase echowire', () {
      expect(InstanceConstants.defaultProductName, 'echowire');
    });
  });
}
