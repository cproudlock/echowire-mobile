import 'package:flutter_test/flutter_test.dart';
import 'package:fluxer_app/core/instance/instance_constants.dart';
import 'package:fluxer_app/features/chat/domain/message.dart';
import 'package:fluxer_app/features/chat/utils/messages/client_system_message.dart';
import 'package:fluxer_app/features/dm/domain/dm_channel_types.dart';

void main() {
  test('createClientSystemMessage uses the system bot author and type 99', () {
    final Message message = createClientSystemMessage(
      channelId: 'channel-1',
      content: 'Delivery failed.',
    );
    expect(message.type, messageTypeClientSystem);
    expect(message.authorId, fluxerBotUserId);
    // The default product name is instance-specific, so assert against the
    // constant the code defaults to rather than a brand literal.
    expect(message.authorName, InstanceConstants.defaultProductName);
    expect(message.authorIsBot, isTrue);
    expect(message.authorIsSystem, isTrue);
    expect(message.isClientSystemMessage, isTrue);
    expect(message.content, 'Delivery failed.');
    expect(message.deliveryState, MessageDeliveryState.sent);
    expect(message.clientNonce, message.id);
  });

  test('createClientSystemMessage brands the system bot with productName', () {
    final Message message = createClientSystemMessage(
      channelId: 'channel-1',
      content: 'Delivery failed.',
      productName: 'Acme',
    );
    expect(message.authorName, 'Acme');
  });
}
