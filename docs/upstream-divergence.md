# Upstream divergence ledger (mobile)

Read this first on every upstream sync. It lists what this fork keeps on top of
`fluxerapp/flutter_client`, so a merge cannot drop one silently. The rule behind it
(ADR 0012 in the server repo): stay as close to upstream as possible, and add our own
behaviour only where it matches Discord, in separate files with few hook points.

Threads and forums: since the sync that adopted upstream's implementation
(`feat(threads): threads, forums and announcement threads`, upstream #961), all thread and
forum Dart code is upstream's. The fork's own implementation was retired. Only the entries
below are ours.

## Thread extras

### Add a member to a thread

- What: a button on the thread members list that opens a member picker and calls
  upstream's `ThreadsRepository.addMember`. Upstream ships the repository call and the
  `canAddThreadMember` check but no UI.
- Discord behaviour it matches: "Add Members" in a thread's member list, offered to people
  who can invite to the thread.
- Files: `lib/features/threads/presentation/echowire_thread_add_member.dart` (whole extra).
- Upstream files it hooks into: `lib/features/threads/presentation/thread_members_sheet.dart`,
  one `EchowireThreadAddMemberButton(...)` line at the top of `ThreadMembersList`.
- Tests: `test/features/threads/echowire_thread_add_member_test.dart`.
- Strings: `threadsAddMember`, `threadsAddMemberSearchLabel`, `threadsAddMemberNoResults`,
  `threadsMemberAddedToast` (fork-only keys in every `.arb`).

### Post header actions (close, lock, leave, delete)

Not an extra any more. Upstream's `buildThreadMenuGroups` (`thread_menu_sheet.dart`), opened
from the channel header, the thread sidebar tile and the forum post actions sheet, already
offers archive (close), lock, leave, delete and member management, gated on the thread
permission helpers. Nothing of ours to carry.

## Compatibility with the fork's own server (until the server is switched)

The mobile release ships before the server runs upstream's thread implementation. The old
server sends threads and forums as ordinary channel rows and never sends the guild
`threads` list, so upstream's client keeps the thread feature off for those guilds. This is
guarded, not assumed:

- `test/features/threads/legacy_server_shape_test.dart` feeds fork-server payloads
  (including a thread with null timestamps) through the real event parser and gateway
  handler and requires: no crash, the guild and its ordinary channels all arrive, threads
  and forums are absent, and a rollback from the new shape back to the old one purges the
  thread rows.
- `lib/features/chat/utils/messages/system_message_text.dart`: `echowireThreadCreatedLabel`
  hides the thread id that the old server wrote into "started a thread" messages.
- `lib/core/database/fluxer_database.dart`, schema step 91: also drops thread and forum rows
  written by builds of the fork's own implementation, once.
- `dart_sdk/test/serialization/channel_response_legacy_thread_shape_test.dart` pins how the
  generated models read the old shape and that channel types 10, 11, 12, 15 and 16 stay
  defined.

Delete this section, the test and the helper once no client talks to the old server.

## Widget-test drift invariant (accepted for upstream's thread providers)

A widget-reachable provider that opens a drift query stream makes every `testWidgets` that
mounts it fail at teardown with a pending-timer error, unless the test overrides the
provider (see the maintainer notes `mobile-widget-tests-forbid-drift-streams` and
`echowire-mobile-widget-drift-invariant`). Upstream's thread providers do open such
streams: `joinedThreadIds`, `threadMembership`, `activeGuildThreads`, `parentThreads`,
`currentMemberTimedOut` (`features/threads/providers/thread_ui_providers.dart`), the forum
post providers, and `thread_welcome_section.dart`. They are accepted as they are, for two
reasons. First, each of the thread-list providers returns `Stream.value(...)` when
`threadChannelsActiveProvider(guildId)` is false, so against a server that does not speak
upstream's thread protocol (the old shape) no drift stream is opened at all. Second,
upstream's own widget tests override them, and the full suite shows no drift-timer failure
in a thread or forum test. The fork's retired `MessageThreadLink` and `_applyThreadState`
watchers, which accounted for the 23 red chat tests, went with the fork's implementation.

Rule for fork code: a widget of ours must read thread state through upstream's providers and
a test of ours must override them, as `echowire_thread_add_member_test.dart` does with
`threadActorContextProvider`.

## Other standing divergences

These are not about threads; the full rules are in the maintainer notes
(`echowire-fork-upstream`, `echowire-mobile-builds`). Listed so a sync checks them:

- Brand: lowercase `echowire`, `org.echowire.*` ids, echowire.org URLs.
- Push: `lib/core/push/services/firebase_messaging_push_service.fcm.dart` and
  `lib/core/push/fcm/fcm_entrypoint.fcm.dart` are ours (raw FCM, no
  `AndroidPushPipeline`); `test/build/conditional_compilation_test.dart` guards it. The
  plaintext FCM display stack in `packages/fluxer_fcm` stays.
- Captcha: hCaptcha and Turnstile client (`packages/fluxer_captcha`, `captcha_dialog.dart`);
  no `altcha_lib`.
- Deep links accept both `echowire://` and `fluxer://`
  (`lib/core/deep_links/deep_link_path_policy.dart` and its test, the second Android
  intent filter, `ios/Runner/Info.plist`).
- Version: `pubspec.yaml` `version:` is hand-managed; a Play version code burns on upload.
- `sentry_flutter` is pinned to 9.26.0 (see the comment in `pubspec.yaml`).
- Upstream nav entries that point at upstream's own properties are hidden: Fluxer Labs
  (`userSettingsShowJoinFluxerLabsNav`) and Give feedback (`userSettingsShowGiveFeedbackNav`) in
  `lib/features/settings/presentation/user_settings_nav.dart`. This fork has no equivalent
  community or feedback portal. If upstream renames either helper the settings modal fails to compile.
- Push is registered through the fork's own FCM path, not upstream's push relay. Upstream's
  `test/core/push/push_relay_consent_unregister_test.dart` expects no direct registration for a
  self-hosted device without relay consent and fails here (checked 2026-10-11); do not "fix" the
  fork to satisfy it.
- Known failing tests after the 2026-10-11 sync (28, all brand or URL assertions that still say
  Fluxer or use fluxer.app hosts, plus the push relay test above): `user_profile_badges_test`,
  `user_profile_view_test`, `message_item_avatar_unset_test`, `fluxer_media_url_test`,
  `deep_link_path_policy_test`, `assistant_entities_test`, `emoji_utils_test`,
  `system_permission_settings_prompt_test`, `splash_screen_test`, `emoji_info_bottom_sheet_test`,
  `fluxer_platform_test`, `instance_discovery_service_test`, `instance_config_snapshot_test`.
  Run the suite one directory at a time; the whole suite in one process hangs in a teardown.
