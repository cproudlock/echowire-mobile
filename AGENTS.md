# Agent instructions

The one committed AI-config file for this project. `CLAUDE.md` is a symlink to
this file; every other tool's config (`GEMINI.md`, `.cursorrules`, `.aiderignore`,
`.serena/`) is gitignored. One file, so it is worth keeping accurate. Accurate as
of 2026-09-14.

## What this project is

echowire-mobile is the echowire chat client for Android and iOS, a Flutter fork
of `fluxerapp/flutter_client` that talks to the echowire.org server built from
the `echowire-next` repo.

- **Branch model:** `canary` is the default branch and the release branch.
  Upstream's branch is also `canary`, not main. Upstream is merged on a
  `merge-upstream-mobile-<date>` branch, then into `canary` with `--no-ff`
  (`chore(merge): bring upstream/canary into canary (N commits)`). Feature work
  goes on `feat/*` or `fix/*` and merges the same way.
- **Remotes:** `origin` = github.com/cproudlock/echowire-mobile,
  `upstream` = github.com/fluxerapp/flutter_client (public HTTPS fetch).
- **Brand:** all lowercase `echowire` in every user-visible string and catalog
  value, even at the start of a sentence. Code identifiers keep their names.
  These cannot change, ever: the package ids (`org.echowire.twa` on Android,
  `org.echowire.ios` on iOS), the Android signing certificate (subject
  `CN=Echowire`, alias `echowire`), and the Firebase project. Changing any of
  them means existing installs can never update.

## How to run and test it

Work in the `dev-personal` Incus container at `~/dev/echowire-mobile`. Nothing
below is on the default PATH:

    export PATH=/home/camp/flutter/bin:$HOME/.cargo/bin:$PATH
    export ANDROID_HOME=/home/camp/android-sdk ANDROID_SDK_ROOT=/home/camp/android-sdk
    export ANDROID_NDK_HOME=/home/camp/android-sdk/ndk/28.2.13676358

The NDK variables matter even though Gradle reads `local.properties`: the Dart
native-assets hook is a separate process, and without them `webcrypto` fails
with `Bad state: No element`. `packages/fluxer_markdown_native` is a Rust crate,
so cargo must be on PATH with the Android targets
(`rustup target add armv7-linux-androideabi aarch64-linux-android i686-linux-android x86_64-linux-android`),
or every dart command dies with `Failed to launch cargo`.

The CI sequence, needed before `flutter analyze` because the `*.g.dart` files
are untracked:

    dart tool/strip_firebase_deps.dart      # ONLY for non-FCM checks, see below
    flutter pub get
    flutter gen-l10n
    dart run build_runner build --delete-conflicting-outputs
    flutter analyze lib

**Gate:** `flutter analyze lib` with 0 errors and 0 warnings. The baseline is
about 54 info-level lints (mostly non-auto-fixable style lints); do not add
more. A wave of undefined generated symbols means build_runner has not run, not
a broken merge. Widget tests (`flutter test`) are blocked locally by the
`fluxer_markdown_native` cargo hook. GitHub Actions is not a gate: the
workflows are inherited from upstream, `dart-analyze.yml` is disabled, and the
account is not paid for.

**Trap:** `strip_firebase_deps.dart` plus `pub get` MUTATE tracked files
(`pubspec.yaml`, `pubspec.lock`, `lib/core/push/fcm/fcm_entrypoint.dart`,
`lib/core/push/services/firebase_messaging_push_service.dart`, and every
platform's generated plugin registrant). Skip it for FCM builds. After a
non-FCM check, `git checkout --` those files before committing, and grep the
staged diff for `^-.*firebase`.

## Releases

Version codes are burned the moment an artifact is **uploaded** to Play, not
when it is released, and Play never allows reuse or lowering. See ADR 0001.

- `pubspec.yaml` (`version: <name>+<code>`) is the single source of truth.
  Upstream commits carry the placeholder `1.0.0+1`; do not trust a diff of
  that line.
- Never invent a code. Read the highest code from the Play Console and from
  `~/echowire-builds/RELEASES.md` (on the **host** camp-AMD, not in the
  container), which has an Uploaded column. Update that row the moment
  anything is uploaded.
- Codes are 8-digit `YYYYMMDD`-shaped, strictly increasing. Never 10 digits:
  it cannot be undone and sits just under Play's 2,100,000,000 ceiling. Bump
  the version name with the code.
- Current: `1.7.25+20260915` on `canary`; the floor is 20260913.

Android (stableFcm; `canaryFcm` cannot build because `google-services.json`
registers only the stable package):

    flutter build appbundle --release --flavor stableFcm \
      --dart-define-from-file=tool/dart_defines/stable.json \
      --dart-define=PUSH_PROVIDER=fcm --dart-define=BUILD_TIMESTAMP=<utc>

Output is `build/app/outputs/bundle/stableFcmRelease/app-stable-fcm-release.aab`.
Copy it to the host as `~/echowire-builds/app-stable-fcm-release-<code>.aab`.
Upload the AAB alone; adding the universal APK to the same release makes Play
reject it as shadowed. `aapt2` and `apksigner` do not read a bundle; the
verification recipes are in `RELEASES.md`.

iOS is never built locally: Codemagic workflow `ios-testflight` in
`codemagic.yaml`, on `canary`. The build number comes from TestFlight, the
version name from pubspec. iOS is APNs-only, so that workflow strips Firebase.

## House rules

- **Theming for new UI:** use the fork's components, never raw Material
  dialogs, menus, chips or snackbars: `FluxerBottomSheet`, `FluxerActionMenu`,
  `FluxerSegmentedTabs`, `toastProvider`, `FluxerListRow`, `FluxerButton`,
  `FluxerInput` (all under `lib/features/ui/`).
- **Strings:** every user-visible string goes in the arb catalogs in `lib/l10n`
  (template `fluxer_en.arb`) with an `@key` description, then `flutter gen-l10n`.
- **Signing files are untracked and must never be committed:**
  `android/app/echowire.keystore`, `android/key.properties`,
  `android/app/google-services.json`. A verified backup is at
  `~/echowire-signing-backup` on the host camp-AMD. Losing them means the app
  can never be updated for existing installs.
- Secrets live in `.env`, never committed. Architectural decisions get an ADR in
  `docs/adr/` using the template there.

## Things that will bite you

- **Upstream widget refactors silently drop fork code.** When upstream splits or
  rewrites a large widget, git auto-merges with no conflict marker and loses the
  fork's additions inside it (the 2026-09-06 merge dropped the thread members
  tab and thread actions menu from `channel_details_sheet.dart`). After any
  such merge, diff the affected directory against the fork base and grep for
  each fork string to confirm it moved rather than vanished. Imports for `part`
  files go in the parent library file.
- **Catalog merges must carry metadata.** A merge keyed only on arb values drops
  the branded `@key` descriptions and still looks clean. The 2026-09-12 merge
  carried 176 values and 136 descriptions.
- **Generated l10n formatting drifts.** CI uses unpinned Flutter stable, so the
  `gen-l10n` plus `git diff --exit-code` check can flip with no code change.
- **PR checks inherited from upstream** (signed commits, DCO, linked issue) fail
  on fork PRs for reasons unrelated to the code.
- **Memory:** do not run a release build alongside the web repo's full vitest
  run or image build; the container's memory cap turns that into hours of thrash.
