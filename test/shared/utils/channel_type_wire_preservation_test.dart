import 'package:flutter_test/flutter_test.dart';
import 'package:fluxer_app/features/channels/domain/channel.dart';
import 'package:fluxer_app/shared/utils/sdk_converters.dart';
import 'package:fluxer_dart/export.dart' as sdk;

/// Echowire fork guard.
///
/// `channelFromSdk` reads the channel type through the SDK's generated
/// `ChannelType` enum. Upstream's OpenAPI spec does not declare the fork's
/// thread (11, 12) and forum (15) types, so a regeneration that drops them
/// makes `ChannelType.fromJson(15)` fall back to `$unknown`, whose `json` is
/// null. `sdk.type.json ?? 0` then stores every forum and thread as a plain
/// text channel, which makes `Channel.isForum` and `Channel.isThread` false
/// everywhere and removes forums from the app without a single error.
void main() {
  sdk.ChannelResponse channel(int type) => sdk.ChannelResponse.fromJson({
    'id': 'c1',
    'type': type,
    'guild_id': 'g1',
    'name': 'post',
  });

  test('channelFromSdk preserves the forum channel type', () {
    final row = channelFromSdk(channel(15), 'g1');
    expect(row.type.value, 15);
    expect(ChannelType.fromWire(row.type.value), ChannelType.guildForum);
  });

  test('channelFromSdk preserves both thread channel types', () {
    expect(channelFromSdk(channel(11), 'g1').type.value, 11);
    expect(channelFromSdk(channel(12), 'g1').type.value, 12);
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
}
