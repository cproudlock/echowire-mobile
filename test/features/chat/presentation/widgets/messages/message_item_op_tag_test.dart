import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fluxer_app/core/theme/fluxer_layout_theme.dart';
import 'package:fluxer_app/core/theme/fluxer_text_theme.dart';
import 'package:fluxer_app/core/theme/fluxer_theme.dart';
import 'package:fluxer_app/core/theme/themes/dark.dart';
import 'package:fluxer_app/features/chat/domain/message.dart';
import 'package:fluxer_app/features/chat/presentation/widgets/messages/message_item.dart';
import 'package:fluxer_app/features/chat/providers/publish_nudge_provider.dart';
import 'package:fluxer_app/features/settings/providers/chat_preferences_provider.dart';
import 'package:fluxer_app/features/ui/badge/fluxer_op_tag.dart';
import 'package:fluxer_app/material_ui.dart';
import 'package:fluxer_dart/export.dart';

import '../../../../../helpers/instance_runtime_config_override.dart';
import '../../../../../helpers/test_l10n.dart';

const String _ownerId = '123456789012345678';
const String _otherId = '987654321098765432';

// Webhook author lets the row resolve its display with no provider or database
// read, matching the other MessageItem tests.
Message _message({required String authorId}) => Message(
  id: '1',
  channelId: 'c1',
  authorId: authorId,
  authorName: 'Webhook',
  webhookId: 'wh1',
  content: 'hello world',
  timestamp: DateTime.utc(2026, 1, 1, 12),
);

MessageRenderSettings _settings({String? threadOwnerId}) =>
    MessageRenderSettings(
      activeGuildId: null,
      renderEmbeds: false,
      renderReactions: false,
      inlineAttachmentMedia: false,
      renderSpoilers: RenderSpoilers.onClick,
      revealSpoilers: false,
      chatPreferences: const ChatPreferencesState(),
      messageGroupSpacing: 16,
      threadOwnerId: threadOwnerId,
    );

Widget _app(Widget child) {
  final colorTheme = buildDarkColorTheme();
  return ProviderScope(
    overrides: [
      instanceRuntimeConfigOverride(),
      // Upstream's crosspost nudge is built inside every row and resolves
      // its target through the chat view model, which opens the database.
      // This row is rendered on its own, so pin the nudge to no message and
      // keep the test free of providers it does not exercise.
      publishNudgeMessageIdProvider.overrideWithValue(null),
    ],
    child: MaterialApp(
      locale: kTestLocale,
      localizationsDelegates: FluxerLocalizations.localizationsDelegates,
      supportedLocales: FluxerLocalizations.supportedLocales,
      theme: buildFluxerTheme(
        colorTheme: colorTheme,
        textTheme: FluxerTextTheme.fromColors(colorTheme),
        layoutTheme: FluxerLayoutTheme.scaled(),
      ),
      home: Scaffold(body: child),
    ),
  );
}

void main() {
  // The OP badge marks the author of the thread or forum post being read, so
  // it may only appear where that context is on screen. The owner therefore
  // arrives through MessageRenderSettings, which the message list supplies,
  // and a row never looks it up itself: doing so opened a drift query stream
  // for every message row.
  //
  // These rows pass isDmChannel so the row does not also build
  // MessageThreadLink, which watches a database-backed stream of its own and
  // is not what is under test here.
  group('MessageItem OP badge', () {
    Future<void> pumpRow(
      WidgetTester tester, {
      required String authorId,
      String? threadOwnerId,
      bool inboxPreviewMode = false,
    }) async {
      await tester.pumpWidget(
        _app(
          MessageItem(
            message: _message(authorId: authorId),
            isDmChannel: true,
            inboxPreviewMode: inboxPreviewMode,
            renderSettings: _settings(threadOwnerId: threadOwnerId),
          ),
        ),
      );
      await tester.pump();
    }

    testWidgets('renders inside a post for the post owner', (tester) async {
      await pumpRow(tester, authorId: _ownerId, threadOwnerId: _ownerId);
      expect(find.byType(FluxerOpTag), findsOneWidget);
    });

    testWidgets('is absent for another author inside the same post', (
      tester,
    ) async {
      await pumpRow(tester, authorId: _otherId, threadOwnerId: _ownerId);
      expect(find.byType(FluxerOpTag), findsNothing);
    });

    testWidgets('is absent when the row has no thread context', (tester) async {
      await pumpRow(tester, authorId: _ownerId);
      expect(find.byType(FluxerOpTag), findsNothing);
    });

    testWidgets('is absent in preview cards even for the post owner', (
      tester,
    ) async {
      await pumpRow(
        tester,
        authorId: _ownerId,
        threadOwnerId: _ownerId,
        inboxPreviewMode: true,
      );
      expect(find.byType(FluxerOpTag), findsNothing);
    });
  });
}
