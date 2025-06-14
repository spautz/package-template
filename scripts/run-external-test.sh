#!/usr/bin/env bash

# Run a single external-test service defined in docker-compose.external-tests.yaml.
# Usage: run-external-test.sh <profile> [extra docker compose args]
# Example: ./scripts/run-external-test.sh cra5-react18 --pull always
#
# The first argument is the service profile name (which also matches the directory name
# in external-tests/).  Any additional arguments are forwarded to `docker compose up`.

set -euo pipefail

PROFILE=${1?profile name (e.g. cra5-react18)}
shift || true
EXTRA_ARGS=${*:-}

# Determine repository root regardless of where the script is invoked from
REPO_ROOT=$(git -C "$(dirname "${BASH_SOURCE[0]:-$0}")/.." rev-parse --show-toplevel)
COMPOSE_FILE="$REPO_ROOT/docker-compose.external-tests.yaml"

# Build & run the container.  We rely on Compose profiles so that only the requested
# service is started.  The container will exit after its CMD finishes (unit tests, etc.)

docker compose -f "$COMPOSE_FILE" \
  --profile "$PROFILE" \
  up --build --abort-on-container-exit \
     --remove-orphans --exit-code-from "$PROFILE" \
  ${EXTRA_ARGS}

# Capture the container ID so we can pull artifacts (coverage reports, lockfiles, ...)
CONTAINER_ID=$(docker compose -f "$COMPOSE_FILE" ps -q "$PROFILE")

# If the container is still around, read the labels to determine which artifacts to copy.
if [[ -n "$CONTAINER_ID" ]]; then
  # Ask Docker for any labels that start with external-test.artifact.
  # Using --format makes it easy to trim the JSON handling.
  mapfile -t ARTIFACTS < <(
    docker inspect \
      --format '{{ range $k,$v := .Config.Labels }}{{ if (hasPrefix $k "external-test.artifact.") }}{{ $v }} {{ end }}{{ end }}' \
      "$CONTAINER_ID"
  )

  for ENTRY in "${ARTIFACTS[@]}"; do
    # Split "src::dst" (or just "src")
    IFS="::" read -r SRC DST <<<"$ENTRY"
    DST=${DST:-$(basename "$SRC")}                      # default: same name
    HOST_PATH="$REPO_ROOT/external-tests/$PROFILE/$DST"

    echo "Copying $SRC -> $HOST_PATH"
    docker cp "$CONTAINER_ID":"$SRC" "$HOST_PATH" 2>/dev/null || true
  done
fi
