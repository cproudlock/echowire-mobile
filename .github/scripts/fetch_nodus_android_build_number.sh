#!/usr/bin/env bash
set -euo pipefail

if [[ -z "${NODUS_CI_TOKEN:-}" ]]; then
  echo "::error::NODUS_CI_TOKEN must be set"
  exit 1
fi

NODUS_APP="${NODUS_APP:-fluxer}"

NODUS_BASE_URL="${NODUS_BASE_URL:-https://nodus.ae1.dev}"
URL="${NODUS_BASE_URL}/v1/apps/${NODUS_APP}/build-numbers/android"
echo "Allocating Android build number at ${URL}"
RESPONSE=$(curl -fS -X POST "$URL" \
  -H "Authorization: Bearer ${NODUS_CI_TOKEN}")
RESPONSE_ONE_LINE=$(printf '%s' "$RESPONSE" | tr -d '\n')
BUILD_NUMBER=$(printf '%s\n' "$RESPONSE_ONE_LINE" | sed -n 's/.*"buildNumber"[[:space:]]*:[[:space:]]*\([0-9][0-9]*\).*/\1/p')
if ! [[ "$BUILD_NUMBER" =~ ^[0-9]+$ ]]; then
  echo "::error::Invalid or missing buildNumber in response: $RESPONSE"
  exit 1
fi

if [[ -n "${GITHUB_OUTPUT:-}" ]]; then
  echo "build_number=$BUILD_NUMBER" >> "$GITHUB_OUTPUT"
else
  echo "$BUILD_NUMBER"
fi
