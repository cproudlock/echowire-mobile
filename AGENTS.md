# Agent instructions

The one committed AI-config file for this project. `CLAUDE.md` is a symlink to
this file; every other tool's config (`GEMINI.md`, `.cursorrules`, `.aiderignore`,
`.serena/`) is gitignored. One file, so it is worth keeping accurate.

## What this project is

One or two sentences. Assume no other context.

## How to run and test it

    <commands>

## House rules

- Toolchain versions come from `.tool-versions`. Do not install globally.
- Compose stacks are named explicitly; do not add unnamed services.
- Secrets live in `.env`, which is never committed. Add new variables to `.env.example`.
- Architectural decisions get an ADR in `docs/adr/` - see the template there.

## Things that will bite you

Anything non-obvious: a service that must be up first, a migration that is not
idempotent, an endpoint that is slow in dev for a known reason.
