import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

// Guard against upstream's product name reaching users. The brand is the
// lowercase "echowire". This scans every Dart string literal under lib/ and
// the English ARB source for the word "Fluxer" and fails on any that survives
// the allow list below. Identifiers (FluxerButton), header names (X-Fluxer-*),
// URLs, package paths and the font name "Fluxer Sans" are not display text.

final RegExp _stringLiteral = RegExp(
  r'''r?'(?:[^'\\\n]|\\.)*'|r?"(?:[^"\\\n]|\\.)*"''',
);

final List<RegExp> _allowed = <RegExp>[
  RegExp(r'https?://\S+', caseSensitive: false),
  RegExp(r'package:\S+'),
  RegExp(r'X-Fluxer-[\w-]+', caseSensitive: false),
  RegExp('Fluxer Sans'),
];

// The word on its own, or glued to lowercase text ("Fluxerverse"). A capital,
// digit or underscore right after it means a type or constant name.
final RegExp _leak = RegExp('(?<![A-Za-z0-9_])Fluxer(?![A-Z0-9_])');

// ARB keys whose English value is dead text: the nav items are hidden by
// userSettingsShowJoinFluxerLabsNav (see docs/upstream-divergence.md).
const Set<String> _arbAllowedKeys = <String>{'userSettingsJoinFluxerLabs'};

// Files that still carry upstream text but are unreachable. The guild
// membership nag bar is switched off in nagbar/nagbar_providers.dart, so
// its 'Fluxer HQ' constant never reaches a screen; the file stays as upstream
// wrote it so a sync merges cleanly.
const Set<String> _allowedFiles = <String>{
  'lib/features/shell/presentation/widgets/nagbars/guild_membership_cta_nagbar.dart',
};

String _stripAllowed(String text) {
  String out = text;
  for (final RegExp pattern in _allowed) {
    out = out.replaceAll(pattern, '');
  }
  return out;
}

bool isBrandLeak(String text) => _leak.hasMatch(_stripAllowed(text));

bool _isGenerated(String path) =>
    path.contains('/l10n/generated/') ||
    path.contains('/synced_preferences/generated/') ||
    path.endsWith('.g.dart') ||
    path.endsWith('.freezed.dart') ||
    path.endsWith('.pb.dart') ||
    path.endsWith('.pbenum.dart') ||
    path.endsWith('.pbjson.dart');

List<String> findDartLeaks(Directory root) {
  final List<String> hits = <String>[];
  for (final FileSystemEntity entity in root.listSync(recursive: true)) {
    if (entity is! File || !entity.path.endsWith('.dart')) {
      continue;
    }
    if (_isGenerated(entity.path) || _allowedFiles.contains(entity.path)) {
      continue;
    }
    final List<String> lines = entity.readAsLinesSync();
    for (int i = 0; i < lines.length; i++) {
      final String trimmed = lines[i].trimLeft();
      if (trimmed.startsWith('//') ||
          trimmed.startsWith('import ') ||
          trimmed.startsWith('export ') ||
          trimmed.startsWith('part ')) {
        continue;
      }
      for (final RegExpMatch match in _stringLiteral.allMatches(lines[i])) {
        if (isBrandLeak(match.group(0)!)) {
          hits.add('${entity.path}:${i + 1}: ${match.group(0)}');
        }
      }
    }
  }
  return hits;
}

List<String> findArbLeaks(File arb) {
  final Map<String, dynamic> json =
      jsonDecode(arb.readAsStringSync()) as Map<String, dynamic>;
  final List<String> hits = <String>[];
  json.forEach((String key, dynamic value) {
    if (key.startsWith('@') || _arbAllowedKeys.contains(key)) {
      return;
    }
    if (value is String && isBrandLeak(value)) {
      hits.add('$key: $value');
    }
  });
  return hits;
}

void main() {
  group('isBrandLeak', () {
    test('flags display text', () {
      expect(isBrandLeak('Unexpected login response from Fluxer API.'), isTrue);
      expect(isBrandLeak('Fluxer'), isTrue);
      expect(isBrandLeak('Welcome to Fluxerverse'), isTrue);
      expect(isBrandLeak('Fluxer HQ'), isTrue);
    });

    test('allows identifiers, headers, urls and the font name', () {
      expect(isBrandLeak('FluxerButton'), isFalse);
      expect(isBrandLeak('FluxerCrashReporting.initialize failed'), isFalse);
      expect(isBrandLeak('X-Fluxer-Features'), isFalse);
      expect(isBrandLeak('https://fluxer.app/Fluxer'), isFalse);
      expect(isBrandLeak('package:fluxer_app/Fluxer.dart'), isFalse);
      expect(isBrandLeak('Fluxer Sans'), isFalse);
      expect(isBrandLeak('echowire'), isFalse);
    });
  });

  test('no Dart string literal under lib/ names Fluxer to users', () {
    final List<String> hits = findDartLeaks(Directory('lib'));
    expect(
      hits,
      isEmpty,
      reason:
          'Upstream branding in a string literal. Use echowire (lowercase) or '
          'the product name, or extend the allow list in '
          'test/build/brand_guard_test.dart if it is not display text:\n'
          '${hits.join('\n')}',
    );
  });

  test('the English ARB source does not name Fluxer to users', () {
    final List<String> hits = findArbLeaks(File('lib/l10n/fluxer_en.arb'));
    expect(
      hits,
      isEmpty,
      reason: 'Upstream branding in fluxer_en.arb:\n${hits.join('\n')}',
    );
  });
}
