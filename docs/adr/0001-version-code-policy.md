# 0001. Take Android version codes from pubspec and never reuse or invent one

## Status

Accepted

Date: 2026-09-14

## Context

Upstream allocates version codes from its own build service, which this fork
cannot reach, so upstream commits leave `pubspec.yaml` at the placeholder
`1.0.0+1`. Google Play never accepts a version code that has been used or is
lower than one already uploaded, even if the release was deleted.

On 2026-09-07 a build was made with `--build-number 20260907`, a date chosen on
the spot, while `pubspec.yaml` said `+96`. It was uploaded to internal testing,
which burned that code, and the follow-up build at `97` was rejected because
testers could not upgrade. It happened again in a different form: 20260911 and
20260912 were each uploaded and then assumed unused, so later attempts were
rejected with "Version code has already been used". A code is spent on upload,
not on release, and nothing in the repo records what was uploaded.

## Decision

- `pubspec.yaml` (`version: <name>+<code>`) is the only source of the version
  code, and the Android workflows read it from there. A `--build-number` flag
  may only repeat the pubspec value, never replace it.
- Before a release build, confirm the highest uploaded code in the Play Console
  and in `~/echowire-builds/RELEASES.md` on the host, bump pubspec above it in
  the release commit, and bump the version name with it.
- Codes keep the 8-digit `YYYYMMDD` shape (or a plain counter) and increase
  strictly. Never jump to 10 digits: codes can never come back down, and a
  10-digit date (`YYYYMMDDNN`) sits within a few percent of Play's
  2,100,000,000 ceiling, leaving no room for any later change of scheme.
- `RELEASES.md` is updated the moment an artifact is uploaded.
- Only the AAB is uploaded to Play.
- iOS build numbers come from TestFlight on Codemagic and are outside this policy.

As of 2026-09-14 the floor is 20260913 and `canary` carries `1.7.25+20260915`.

## Consequences

- A date-shaped code can run ahead of the calendar (20260915 was set on
  2026-09-14), and each rejected or superseded build pushes it further ahead.
- The upload record lives on the host outside the repo, so it must be backed up
  and kept current by hand.
- Upstream merges touching the `version:` line must keep the fork's value.
- A 10-digit date scheme is off the table for good.

## Alternatives considered

- Upstream's build service: not reachable by the fork.
- 10-digit `YYYYMMDDNN` codes: irreversible and pressed against Play's ceiling.
- Plain incrementing counter: allowed, but the date shape is already in use and
  codes cannot go down.
