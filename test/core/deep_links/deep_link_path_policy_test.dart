import 'package:fluxer_app/core/deep_links/deep_link_path_policy.dart';
import 'package:test/test.dart';

void main() {
  group('isAllowedDeepLinkPath', () {
    test('allows channel, invite, gift, user, and settings paths', () {
      const allowedPaths = [
        '/channels/@me',
        '/channels/123456789012345678/987654321098765432',
        '/invite/abc',
        '/gift/xyz',
        '/users/123456789012345678',
        '/settings/user',
        '/settings/user?tab=appearance',
        '/notifications',
        '/you',
      ];
      for (final String path in allowedPaths) {
        expect(
          isAllowedDeepLinkPath(Uri.parse('https://web.fluxer.app$path')),
          isTrue,
          reason: path,
        );
      }
    });

    test('ignores root, auth, admin, and infra paths', () {
      for (final String path in _ignoredDeepLinkPaths) {
        expect(
          isAllowedDeepLinkPath(Uri.parse('https://web.fluxer.app$path')),
          isFalse,
          reason: path,
        );
      }
    });

    test('rejects paths with blocklisted characters', () {
      expect(
        isAllowedDeepLinkPath(
          Uri.parse("https://web.fluxer.app/channels/'evil"),
        ),
        isFalse,
      );
    });

    test('allows fluxer:// app protocol URLs', () {
      const allowedFluxerUrls = [
        'fluxer://channels/@me',
        'fluxer://channels/123456789012345678/987654321098765432',
        'fluxer://invite/abc',
        'fluxer://gift/xyz',
        'fluxer://users/123456789012345678',
        'fluxer://settings/user',
        'fluxer://settings/user?tab=appearance',
        'fluxer://notifications',
        'fluxer://you',
        'fluxer:/channels/@me',
      ];
      for (final String url in allowedFluxerUrls) {
        expect(isAllowedDeepLinkPath(Uri.parse(url)), isTrue, reason: url);
      }
    });

    test('allows echowire:// app protocol URLs the same way', () {
      const allowedEchowireUrls = [
        'echowire://channels/@me',
        'echowire://channels/123456789012345678/987654321098765432',
        'echowire://invite/abc',
        'echowire://gift/xyz',
        'echowire://users/123456789012345678',
        'echowire://settings/user',
        'echowire://settings/user?tab=appearance',
        'echowire://notifications',
        'echowire://you',
        'echowire:/channels/@me',
      ];
      for (final String url in allowedEchowireUrls) {
        expect(isAllowedDeepLinkPath(Uri.parse(url)), isTrue, reason: url);
      }
    });

    test('ignores echowire:// auth and infra paths', () {
      const ignoredEchowireUrls = [
        'echowire://auth/sso/callback?code=1&state=2',
        'echowire://login',
        'echowire://',
      ];
      for (final String url in ignoredEchowireUrls) {
        expect(isAllowedDeepLinkPath(Uri.parse(url)), isFalse, reason: url);
      }
    });

    test('ignores fluxer:// auth and infra paths', () {
      const ignoredFluxerUrls = [
        'fluxer://auth/sso/callback?code=1&state=2',
        'fluxer://login',
        'fluxer://',
      ];
      for (final String url in ignoredFluxerUrls) {
        expect(isAllowedDeepLinkPath(Uri.parse(url)), isFalse, reason: url);
      }
    });
  });

  group('normalizeAppProtocolDeepLinkUri', () {
    test('maps host-style fluxer URLs to path form', () {
      expect(
        normalizeAppProtocolDeepLinkUri(
          Uri.parse('fluxer://channels/@me/123'),
        ).path,
        '/channels/@me/123',
      );
      expect(
        normalizeAppProtocolDeepLinkUri(Uri.parse('fluxer://invite/abc')).path,
        '/invite/abc',
      );
      expect(
        normalizeAppProtocolDeepLinkUri(
          Uri.parse('fluxer://settings/user?tab=appearance'),
        ),
        Uri(path: '/settings/user', queryParameters: {'tab': 'appearance'}),
      );
    });

    test('maps host-style echowire URLs to the same path form', () {
      expect(
        normalizeAppProtocolDeepLinkUri(
          Uri.parse('echowire://channels/@me/123'),
        ).path,
        '/channels/@me/123',
      );
      expect(
        normalizeAppProtocolDeepLinkUri(
          Uri.parse('echowire://invite/abc'),
        ).path,
        '/invite/abc',
      );
      expect(
        normalizeAppProtocolDeepLinkUri(
          Uri.parse('echowire://settings/user?tab=appearance'),
        ),
        Uri(path: '/settings/user', queryParameters: {'tab': 'appearance'}),
      );
    });

    test('does not treat a different scheme as ours', () {
      final Uri uri = Uri.parse('discord://invite/abc');
      expect(normalizeAppProtocolDeepLinkUri(uri), uri);
    });

    test('leaves https URLs unchanged', () {
      final Uri uri = Uri.parse('https://web.fluxer.app/channels/@me');
      expect(normalizeAppProtocolDeepLinkUri(uri), uri);
    });
  });

  group('normalizeInviteDeepLinkUri', () {
    test('maps fluxer.gg short links to invite paths', () {
      expect(
        normalizeInviteDeepLinkUri(Uri.parse('https://fluxer.gg/abcd')).path,
        '/invite/abcd',
      );
      expect(
        normalizeInviteDeepLinkUri(
          Uri.parse('https://fluxer.gg/invite/abcd'),
        ).path,
        '/invite/abcd',
      );
      expect(
        normalizeIncomingDeepLinkUri(
          Uri.parse('https://web.fluxer.app/invite/abcd'),
        ).path,
        '/invite/abcd',
      );
    });

    test('allows fluxer.gg short links through isAllowedDeepLinkPath', () {
      expect(
        isAllowedDeepLinkPath(Uri.parse('https://fluxer.gg/abcd')),
        isTrue,
      );
    });
  });

  group('normalizeDeepLinkPath', () {
    test('trims trailing slashes and preserves root', () {
      expect(normalizeDeepLinkPath('/channels/@me/'), '/channels/@me');
      expect(normalizeDeepLinkPath('/'), '/');
      expect(normalizeDeepLinkPath(''), '/');
    });
  });

  group('isFluxerOAuthDeepLinkUri', () {
    test('matches oauth authorize paths on official Fluxer web hosts', () {
      const oauthUrls = <String>[
        'https://web.fluxer.app/oauth2/authorize?client_id=abc',
        'https://fluxer.app/oauth2/authorize?client_id=abc',
        'https://web.canary.fluxer.app/oauth2/authorize',
        'https://web.canary.fluxer.com/oauth2/authorize/consent',
      ];
      for (final String url in oauthUrls) {
        expect(isFluxerOAuthDeepLinkUri(Uri.parse(url)), isTrue, reason: url);
      }
    });

    test('does not match fluxer:// oauth URLs', () {
      expect(
        isFluxerOAuthDeepLinkUri(
          Uri.parse('fluxer://oauth2/authorize?client_id=abc'),
        ),
        isFalse,
      );
    });

    test('matches self-hosted instance web app host', () {
      expect(
        isFluxerOAuthDeepLinkUri(
          Uri.parse('https://chat.example.com/oauth2/authorize'),
          instanceWebAppBase: 'https://chat.example.com',
        ),
        isTrue,
      );
    });

    test('does not match oauth paths on unrelated hosts', () {
      expect(
        isFluxerOAuthDeepLinkUri(
          Uri.parse('https://evil.com/oauth2/authorize'),
        ),
        isFalse,
      );
    });

    test('does not match non-oauth paths on Fluxer hosts', () {
      expect(
        isFluxerOAuthDeepLinkUri(
          Uri.parse('https://web.fluxer.app/channels/@me'),
        ),
        isFalse,
      );
    });
  });

  group('app protocol schemes', () {
    test('answers to echowire and keeps fluxer, and still writes fluxer', () {
      expect(appProtocolSchemes, {'echowire', 'fluxer'});
      expect(appProtocolScheme, 'fluxer');
    });

    test('recognises either scheme case-insensitively and nothing else', () {
      expect(isAppProtocolScheme('echowire'), isTrue);
      expect(isAppProtocolScheme('FLUXER'), isTrue);
      expect(isAppProtocolScheme('https'), isFalse);
      expect(isAppProtocolScheme('echowirex'), isFalse);
    });

    test('finds the scheme a link starts with', () {
      expect(appProtocolSchemeOf('echowire://invite/abc'), 'echowire');
      expect(appProtocolSchemeOf('fluxer:/channels/@me'), 'fluxer');
      expect(appProtocolSchemeOf('Echowire:gift/xyz'), 'echowire');
      expect(appProtocolSchemeOf('https://echowire.org/invite/abc'), isNull);
      expect(appProtocolSchemeOf('echowirex://invite/abc'), isNull);
    });
  });
}

const List<String> _ignoredDeepLinkPaths = [
  '/',
  '/authorize-ip',
  '/login',
  '/register',
  '/forgot',
  '/verify',
  '/wasntme',
  '/pending',
  '/oauth2/authorize',
  '/auth/sso/callback',
  '/report',
  '/admin',
  '/premium-callback',
  '/age-verification-callback',
  '/connection-callback',
  '/theme-studio',
  '/theme/my-theme',
  '/bookmarks',
  '/mentions',
  '/settings/guild/123',
  '/.well-known/fluxer',
  '/_health',
];
