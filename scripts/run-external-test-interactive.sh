#!/usr/bin/env bash

# Interactive variant – drops you into a shell inside the requested external test
# container with all service ports forwarded.
# Usage: run-external-test-interactive.sh <profile> [target] [extra docker compose args]

set -euo pipefail

PROFILE=${1?profile name (e.g. cra5-react18)}
shift || true

TARGET="default"
if [[ $# -gt 0 && "$1" != -* ]]; then
    TARGET="$1"
    shift || true
fi

EXTRA_ARGS=${*:-}

REPO_ROOT=$(git -C "$(dirname "${BASH_SOURCE[0]:-$0}")/.." rev-parse --show-toplevel)
COMPOSE_FILE="$REPO_ROOT/docker-compose.external-tests.yaml"

export DOCKER_BUILD_TARGET="$TARGET"
docker compose -f "$COMPOSE_FILE" \
  --profile "$PROFILE" \
  run --build --service-ports "$PROFILE" bash ${EXTRA_ARGS}
