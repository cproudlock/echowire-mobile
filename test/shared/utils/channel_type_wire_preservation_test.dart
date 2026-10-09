import 'package:flutter_test/flutter_test.dart';
import 'package:fluxer_app/features/channels/domain/channel.dart';
import 'package:fluxer_app/shared/utils/sdk_converters.dart';
import 'package:fluxer_dart/export.dart' as sdk;

/// Echowire guard.
///
/// `channelFromSdk` reads the channel type through the SDK's generated
/// `ChannelType` enum. Until 2026-10 upstream's spec did not declare thread and
/// forum types, so the fork hand-added 11, 12 and 15 to the generated enum; a
/// regeneration that dropped them turned every forum and thread into a plain
/// text channel without a single error. Upstream's spec now declares them
/// (announcement thread 10, public thread 11, private thread 12, forum 15,
/// media 16), so the enum carries them natively. This test stays so that a
/// future regeneration that drops any of them fails here instead of in
/// production.
///
/// The SDK repo has the matching guard in
/// `dart_sdk/test/serialization/channel_response_legacy_thread_shape_test.dart`.
void main() {
  sdk.ChannelResponse channel(int type) => sdk.ChannelResponse.fromJson({
    'id': 'c1',
    'type': type,
    'guild_id': 'g1',
    'name': 'post',
  });

  test('every thread and forum wire value is defined by the SDK enum', () {
    final Set<int> defined = sdk.ChannelType.$valuesDefined
        .map((sdk.ChannelType t) => t.json!)
        .toSet();
    expect(defined, containsAll(<int>[0, 1, 2, 3, 4, 5, 10, 11, 12, 15, 16]));
  });

  test('channelFromSdk preserves the forum channel type', () {
    final row = channelFromSdk(channel(15), 'g1');
    expect(row.type.value, 15);
    expect(ChannelType.fromWire(row.type.value), ChannelType.guildForum);
  });

  test('channelFromSdk preserves every thread channel type', () {
    expect(channelFromSdk(channel(10), 'g1').type.value, 10);
    expect(channelFromSdk(channel(11), 'g1').type.value, 11);
    expect(channelFromSdk(channel(12), 'g1').type.value, 12);
    expect(
      ChannelType.fromWire(channelFromSdk(channel(10), 'g1').type.value),
      ChannelType.announcementThread,
    );
    expect(
      ChannelType.fromWire(channelFromSdk(channel(11), 'g1').type.value),
      ChannelType.publicThread,
    );
    expect(
      ChannelType.fromWire(channelFromSdk(channel(12), 'g1').type.value),
      ChannelType.privateThread,
    );
  });

  test('channelFromSdk still maps the plain upstream types', () {
    expect(channelFromSdk(channel(0), 'g1').type.value, 0);
    expect(channelFromSdk(channel(2), 'g1').type.value, 2);
    expect(channelFromSdk(channel(998), 'g1').type.value, 998);
  });

  test('a wire type nobody defined never becomes a text channel', () {
    final row = channelFromSdk(channel(4242), 'g1');
    expect(row.type.value, isNot(0));
    expect(ChannelType.fromWire(row.type.value), ChannelType.unknown);
  });
}
