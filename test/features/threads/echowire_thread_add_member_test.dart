import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fluxer_app/core/permissions/permission.dart';
import 'package:fluxer_app/core/permissions/thread_permissions.dart';
import 'package:fluxer_app/core/theme/fluxer_layout_theme.dart';
import 'package:fluxer_app/core/theme/fluxer_text_theme.dart';
import 'package:fluxer_app/core/theme/fluxer_theme.dart';
import 'package:fluxer_app/core/theme/themes/dark.dart';
import 'package:fluxer_app/features/channels/domain/channel.dart';
import 'package:fluxer_app/features/threads/presentation/echowire_thread_add_member.dart';
import 'package:fluxer_app/features/threads/providers/thread_ui_providers.dart';
import 'package:fluxer_app/material_ui.dart';
import 'package:riverpod/src/framework.dart' show Override;

import '../../helpers/instance_runtime_config_override.dart';
import '../../helpers/test_l10n.dart';

/// Echowire extra: the add-member button on the thread members list.
///
/// Upstream ships the repository call and the permission check but no UI.
/// This pins when our button is offered, so a merge that reshapes
/// `ThreadMembersList` cannot silently turn it into one that is always shown
/// or never shown.
const String _threadId = '2000';

const int _typePublic = 11;
const int _typePrivate = 12;

int _perms(List<Permission> permissions) =>
    permissions.fold<int>(0, (int acc, Permission p) => acc | p.value);

ThreadActorContext _actor({
  required List<Permission> permissions,
  int type = _typePublic,
  bool archived = false,
  bool locked = false,
  bool invitable = true,
  bool isThreadOwner = false,
}) => ThreadActorContext(
  permissions: _perms(permissions),
  thread: ThreadFacts(
    type: type,
    archived: archived,
    locked: locked,
    invitable: invitable,
  ),
  isThreadOwner: isThreadOwner,
  isMember: true,
);

const Channel _thread = Channel(
  id: _threadId,
  guildId: 'g1',
  name: 'a thread',
  type: ChannelType.publicThread,
  parentId: '1000',
);

Widget _host({ThreadActorContext? actor}) {
  final colorTheme = buildDarkColorTheme();
  return ProviderScope(
    overrides: <Override>[
      instanceRuntimeConfigOverride(),
      threadActorContextProvider(_threadId).overrideWithValue(actor),
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
      home: Builder(
        builder: (BuildContext context) => Scaffold(
          body: EchowireThreadAddMemberButton(
            thread: _thread,
            hostContext: context,
          ),
        ),
      ),
    ),
  );
}

void main() {
  group('echowireCanOfferAddMember', () {
    test('is false without an actor', () {
      expect(echowireCanOfferAddMember(null), isFalse);
    });

    test('is true for a member who can view and send in a public thread', () {
      expect(
        echowireCanOfferAddMember(
          _actor(
            permissions: <Permission>[
              Permission.viewChannel,
              Permission.sendMessagesInThreads,
            ],
          ),
        ),
        isTrue,
      );
    });

    test('is false when the thread is archived', () {
      expect(
        echowireCanOfferAddMember(
          _actor(
            permissions: <Permission>[
              Permission.viewChannel,
              Permission.sendMessagesInThreads,
            ],
            archived: true,
          ),
        ),
        isFalse,
      );
    });

    test('is false for someone who cannot send messages', () {
      expect(
        echowireCanOfferAddMember(
          _actor(permissions: <Permission>[Permission.viewChannel]),
        ),
        isFalse,
      );
    });

    test('is false in a locked thread unless the actor moderates it', () {
      final List<Permission> member = <Permission>[
        Permission.viewChannel,
        Permission.sendMessagesInThreads,
      ];
      expect(
        echowireCanOfferAddMember(_actor(permissions: member, locked: true)),
        isFalse,
      );
      expect(
        echowireCanOfferAddMember(
          _actor(
            permissions: <Permission>[...member, Permission.manageThreads],
            locked: true,
          ),
        ),
        isTrue,
      );
    });

    test('a private thread that is not invitable needs a moderator', () {
      final List<Permission> member = <Permission>[
        Permission.viewChannel,
        Permission.sendMessagesInThreads,
      ];
      expect(
        echowireCanOfferAddMember(
          _actor(permissions: member, type: _typePrivate, invitable: false),
        ),
        isFalse,
      );
      expect(
        echowireCanOfferAddMember(
          _actor(permissions: member, type: _typePrivate),
        ),
        isTrue,
      );
      expect(
        echowireCanOfferAddMember(
          _actor(
            permissions: <Permission>[...member, Permission.manageThreads],
            type: _typePrivate,
            invitable: false,
          ),
        ),
        isTrue,
      );
    });
  });

  group('EchowireThreadAddMemberButton', () {
    testWidgets('shows "Add member" when the actor may add people', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        _host(
          actor: _actor(
            permissions: <Permission>[
              Permission.viewChannel,
              Permission.sendMessagesInThreads,
            ],
          ),
        ),
      );
      await tester.pump();
      expect(find.text('Add member'), findsOneWidget);
    });

    testWidgets('shows nothing when the actor may not add people', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        _host(actor: _actor(permissions: <Permission>[Permission.viewChannel])),
      );
      await tester.pump();
      expect(find.text('Add member'), findsNothing);
    });

    testWidgets('shows nothing while the actor is unknown', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(_host());
      await tester.pump();
      expect(find.text('Add member'), findsNothing);
    });
  });
}
