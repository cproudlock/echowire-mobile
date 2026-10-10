import 'package:flutter_test/flutter_test.dart';
import 'package:fluxer_app/core/api/fluxer_api_features.dart';
import 'package:fluxer_app/core/database/fluxer_database.dart';
import 'package:fluxer_app/core/gateway/gateway_event_handler.dart';
import 'package:fluxer_app/core/providers/gateway_connection_provider.dart';
import 'package:fluxer_app/features/chat/utils/messages/system_message_text.dart';
import 'package:fluxer_app/features/threads/providers/thread_guild_gate_provider.dart';
import 'package:fluxer_dart/export.dart';
import 'package:fluxer_dart/gateway.dart';
import 'package:fluxer_dart/gateway_client/event_parser.dart';

import '../../helpers/open_test_database.dart';

/// Echowire regression test: the new app against the OLD (fork) server shape.
///
/// During rollout the mobile release ships before the server is switched to
/// upstream's thread implementation. The old server sends threads and forums
/// as ordinary channel rows (types 11, 12 and 15 with the fork's `pinned`,
/// `require_tag`, `recent_participant_ids` and a `thread_metadata` whose
/// timestamps may be null) inside the guild's `channels` array, and never sends
/// the guild `threads` list that upstream's client treats as "threads are on".
///
/// Contract this file pins:
/// - nothing throws and no guild is lost, in READY, GUILD_CREATE or live events;
/// - the guild's ordinary channels (text, voice, category, announcement) all
///   arrive;
/// - threads and forums are simply absent (the gate stays off), not half
///   stored, and a malformed thread row cannot take the guild down with it;
/// - going from the new server shape back to the old one (rollback) purges the
///   thread rows and keeps the ordinary channels.
///
/// The matching wire shape of the old server is
/// `serializeThreadChannel` / `serializeGuildForumChannel` in the fork's
/// `fluxer_api/src/api/channel/ChannelMappers.ts` (branch echowire).
const String _guildId = 'g1';
const String _textId = '1000';
const String _voiceId = '1001';
const String _forumId = '1002';
const String _threadId = '2000';
const String _privateThreadId = '2001';
const String _brokenThreadId = '2002';

Map<String, Object?> _channel(String id, int type, {String? parentId}) =>
    <String, Object?>{
      'id': id,
      'type': type,
      'guild_id': _guildId,
      'name': 'channel-$id',
      'position': 0,
      'parent_id': ?parentId,
    };

/// A forum exactly as the old server serialises it.
Map<String, Object?> _legacyForum() => <String, Object?>{
  ..._channel(_forumId, 15),
  'topic': 'guidelines',
  'rate_limit_per_user': 0,
  'available_tags': <Map<String, Object?>>[
    <String, Object?>{'id': '9', 'name': 'bug', 'moderated': false},
  ],
  'default_reaction_emoji': <String, Object?>{
    'emoji_id': null,
    'emoji_name': 'eyes',
  },
  'default_sort_order': 0,
  'default_auto_archive_duration': 4320,
  'require_tag': true,
  'default_forum_layout': 1,
  'default_thread_rate_limit_per_user': 0,
};

/// A thread exactly as the old server serialises it.
Map<String, Object?> _legacyThread(
  String id, {
  int type = 11,
  String? archiveTimestamp = '2026-09-27T10:00:00.000Z',
  String? createTimestamp = '2026-09-27T09:00:00.000Z',
}) => <String, Object?>{
  ..._channel(id, type, parentId: _forumId),
  'owner_id': '100',
  'rate_limit_per_user': 0,
  'member_count': 3,
  'message_count': 7,
  'recent_participant_ids': <String>['100', '101'],
  'pinned': true,
  'applied_tags': <String>['9'],
  'thread_metadata': <String, Object?>{
    'archived': false,
    'auto_archive_duration': 4320,
    'archive_timestamp': archiveTimestamp,
    'locked': false,
    'invitable': true,
    'create_timestamp': createTimestamp,
  },
};

Map<String, dynamic> _legacyGuild() => <String, dynamic>{
  'id': _guildId,
  'properties': <String, Object?>{
    'id': _guildId,
    'name': 'Guild',
    'splash_card_alignment': 0,
    'owner_id': '999',
    'system_channel_flags': 0,
    'afk_timeout': 300,
    'features': <String>[],
    'verification_level': 0,
    'mfa_level': 0,
    'nsfw_level': 0,
    'nsfw': false,
    'content_warning_level': 0,
    'explicit_content_filter': 0,
    'default_message_notifications': 0,
    'disabled_operations': 0,
  },
  // No `threads` key: the old gateway has no such field.
  'channels': <Map<String, Object?>>[
    _channel(_textId, 0),
    _channel(_voiceId, 2),
    _legacyForum(),
    _legacyThread(_threadId),
    _legacyThread(_privateThreadId, type: 12),
    // Null timestamps: the old server serialises them as null when a row has
    // none, which upstream's generated model rejects.
    _legacyThread(
      _brokenThreadId,
      archiveTimestamp: null,
      createTimestamp: null,
    ),
  ],
  'members': <Map<String, Object?>>[],
  'roles': <Map<String, Object?>>[],
  'presences': <Map<String, Object?>>[],
  'voice_states': <Map<String, Object?>>[],
  'emojis': <Map<String, Object?>>[],
  'stickers': <Map<String, Object?>>[],
};

class _Harness {
  _Harness(this.database, this.gate, this.handler);

  final FluxerDatabase database;
  final ThreadsGate gate;
  final GatewayEventHandler handler;
}

_Harness _build() {
  final FluxerDatabase database = openTestDatabase();
  final ThreadsGate gate = ThreadsGate();
  final GatewayEventHandler handler = GatewayEventHandler(
    database: database,
    currentUserId: '100',
    threadsGate: gate,
  );
  return _Harness(database, gate, handler);
}

Future<void> _ready(GatewayEventHandler handler, Map<String, dynamic> guild) =>
    handler.handle(
      ReadyEvent(
        sessionId: 'session-1',
        user: _user(),
        guilds: const [],
        rawGuilds: [guild],
        privateChannels: const [],
        relationships: const [],
        readStates: const [],
        presences: const [],
      ),
    );

Future<void> _expectOrdinaryChannelsOnly(_Harness h) async {
  expect(h.gate.isActive(_guildId), isFalse);
  final Server? server = await h.database.guildDao.getServerById(_guildId);
  expect(server, isNotNull, reason: 'the guild must not be lost');
  expect(server!.threadChannelsActive, isFalse);
  expect(await h.database.channelDao.getChannelById(_textId), isNotNull);
  expect(await h.database.channelDao.getChannelById(_voiceId), isNotNull);
  for (final String gated in <String>[
    _forumId,
    _threadId,
    _privateThreadId,
    _brokenThreadId,
  ]) {
    expect(
      await h.database.channelDao.getChannelById(gated),
      isNull,
      reason: 'thread-feature channel $gated must be absent, not half stored',
    );
  }
  expect(await h.database.threadDao.getJoinedThreadIds(), isEmpty);
}

void main() {
  group('what the new app sends', () {
    test('identify carries the CHANNEL_THREADS flag the new gateway reads', () {
      // fluxer_gateway session_manager_shard_drain.erl:
      // IDENTIFY_FLAG_CHANNEL_THREADS is 16#4 (DEBOUNCE_MESSAGE_REACTIONS 16#2).
      expect(kGatewayChannelThreads, 4);
    });

    test('REST requests advertise channel_threads in X-Fluxer-Features', () {
      expect(fluxerApiClientFeatures, contains('channel_threads'));
    });
  });

  group('against the old (fork) server shape', () {
    test('READY keeps the guild and its ordinary channels', () async {
      final _Harness h = _build();
      await _ready(h.handler, _legacyGuild());
      await Future<void>.delayed(const Duration(milliseconds: 50));
      await _expectOrdinaryChannelsOnly(h);
    });

    test('GUILD_CREATE keeps the guild and its ordinary channels', () async {
      final _Harness h = _build();
      await _ready(h.handler, _legacyGuild());
      await h.handler.handle(
        GuildCreateEvent(guild: GuildCreateData.fromJson(_legacyGuild())),
      );
      await Future<void>.delayed(const Duration(milliseconds: 50));
      await _expectOrdinaryChannelsOnly(h);
    });

    test('the SDK drops only the malformed thread row, not the guild', () {
      final GuildCreateData data = GuildCreateData.fromJson(_legacyGuild());
      expect(data.threads, isNull);
      final Set<String> ids = data.channels.map((c) => c.id).toSet();
      expect(ids, containsAll(<String>[_textId, _voiceId, _forumId]));
      expect(ids, contains(_threadId));
      expect(ids, isNot(contains(_brokenThreadId)));
    });

    test(
      'live thread and forum events from the old server are ignored',
      () async {
        final _Harness h = _build();
        await _ready(h.handler, _legacyGuild());
        const EventParser parser = EventParser();
        for (final Map<String, Object?> row in <Map<String, Object?>>[
          _legacyForum(),
          _legacyThread(_threadId),
          _legacyThread(_privateThreadId, type: 12),
        ]) {
          for (final String event in <String>[
            'CHANNEL_CREATE',
            'CHANNEL_UPDATE',
          ]) {
            await h.handler.handle(parser.parse(event, row));
          }
        }
        await h.handler.handle(
          parser.parse('CHANNEL_UPDATE_BULK', <String, dynamic>{
            'channels': <Map<String, Object?>>[
              _legacyThread(_threadId),
              _channel(_textId, 0),
            ],
          }),
        );
        // A malformed row falls through the parser as an unknown event.
        await h.handler.handle(
          parser.parse(
            'CHANNEL_CREATE',
            _legacyThread(
              _brokenThreadId,
              archiveTimestamp: null,
              createTimestamp: null,
            ),
          ),
        );
        await Future<void>.delayed(const Duration(milliseconds: 50));
        await _expectOrdinaryChannelsOnly(h);
      },
    );

    test(
      'messages in a thread channel the app never stored are harmless',
      () async {
        final _Harness h = _build();
        await _ready(h.handler, _legacyGuild());
        final GatewayEvent event = const EventParser().parse(
          'MESSAGE_CREATE',
          <String, dynamic>{
            'id': '5000',
            'channel_id': _threadId,
            'guild_id': _guildId,
            'channel_type': 11,
            'author': <String, Object?>{
              'id': '300',
              'username': 'author',
              'discriminator': '0001',
              'global_name': null,
              'avatar': null,
              'avatar_color': null,
              'flags': 0,
            },
            'type': 0,
            'flags': 0,
            'content': 'hello',
            'timestamp': '2026-09-27T10:00:00.000Z',
            'pinned': false,
            'mention_everyone': false,
            'tts': false,
            'mentions': <Object?>[],
            'mention_roles': <Object?>[],
          },
        );
        await h.handler.handle(event);
        await Future<void>.delayed(const Duration(milliseconds: 50));
        expect(await h.database.channelDao.getChannelById(_threadId), isNull);
        expect(await h.database.channelDao.getChannelById(_textId), isNotNull);
      },
    );
  });

  group('thread-created system messages from the old server', () {
    // The old server wrote the thread's channel id into the message content;
    // upstream's writes the thread name. A bare id must not be shown as a name.
    test('a bare snowflake falls back to the generic label', () {
      expect(echowireThreadCreatedLabel('1234567890123456789'), isNull);
      expect(echowireThreadCreatedLabel('  1234567890123456789 '), isNull);
      expect(echowireThreadCreatedLabel(''), isNull);
    });

    test('a real name is kept, including one that is mostly digits', () {
      expect(echowireThreadCreatedLabel('bug report'), 'bug report');
      expect(echowireThreadCreatedLabel('2026 plans'), '2026 plans');
      expect(echowireThreadCreatedLabel('12345'), '12345');
    });
  });

  group('server rollout order', () {
    test(
      'new server shape then back to the old one keeps the channels',
      () async {
        final _Harness h = _build();
        final Map<String, dynamic> upstreamShape = _legacyGuild()
          ..['threads'] = <Map<String, Object?>>[];
        await _ready(h.handler, upstreamShape);
        await Future<void>.delayed(const Duration(milliseconds: 50));
        expect(h.gate.isActive(_guildId), isTrue);

        // A rollback of the server: the same guild now arrives without threads.
        await _ready(h.handler, _legacyGuild());
        await Future<void>.delayed(const Duration(milliseconds: 50));
        await _expectOrdinaryChannelsOnly(h);
      },
    );

    test('old server shape then the new one turns threads on', () async {
      final _Harness h = _build();
      await _ready(h.handler, _legacyGuild());
      final Map<String, dynamic> upstreamShape = _legacyGuild()
        ..['threads'] = <Map<String, Object?>>[];
      await _ready(h.handler, upstreamShape);
      await Future<void>.delayed(const Duration(milliseconds: 50));
      expect(h.gate.isActive(_guildId), isTrue);
      expect(await h.database.channelDao.getChannelById(_textId), isNotNull);
    });
  });
}

UserPrivateResponse _user() => UserPrivateResponse.fromJson({
  'id': '100',
  'username': 'tester',
  'discriminator': '0001',
  'global_name': null,
  'avatar': null,
  'avatar_color': null,
  'bot': false,
  'system': false,
  'flags': 0,
  'is_staff': false,
  'acls': <String>[],
  'traits': <String>[],
  'email': null,
  'phone': null,
  'bio': null,
  'pronouns': null,
  'accent_color': null,
  'banner': null,
  'banner_color': null,
  'mfa_enabled': false,
  'verified': true,
  'has_verified_phone': false,
  'premium_type': null,
  'premium_since': null,
  'premium_until': null,
  'premium_will_cancel': false,
  'premium_billing_cycle': null,
  'premium_lifetime_sequence': null,
  'premium_badge_hidden': false,
  'premium_badge_masked': false,
  'premium_badge_timestamp_hidden': false,
  'premium_badge_sequence_hidden': false,
  'premium_purchase_disabled': false,
  'premium_enabled_override': false,
  'premium_discriminator': false,
  'premium_perks_disabled': false,
  'password_last_changed_at': null,
  'required_actions': <String>[],
  'nsfw_allowed': true,
  'has_dismissed_premium_onboarding': false,
  'has_ever_purchased': false,
  'has_unread_gift_inventory': false,
  'unread_gift_inventory_count': 0,
  'used_mobile_client': true,
  'pending_bulk_message_deletion': null,
});
