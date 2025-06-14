#!/usr/bin/env bash

# Run a single external-test service defined in docker-compose.external-tests.yaml.
# Usage: run-external-test.sh <profile> [target] [extra docker compose args]
# Example: ./scripts/run-external-test.sh cra5-react18 run-ci --pull always
#
# The first argument is the service profile name (which also matches the directory name
# in external-tests/).
# The second optional argument is the Dockerfile target (e.g., 'run-all', 'run-ci').
# Any additional arguments are forwarded to `docker compose up`.

set -euo pipefail

PROFILE=${1?profile name (e.g. cra5-react18)}
shift || true

TARGET="default"
if [[ $# -gt 0 && "$1" != -* ]]; then
    TARGET="$1"
    shift || true
fi

EXTRA_ARGS=${*:-}

# Determine repository root regardless of where the script is invoked from
REPO_ROOT=$(git -C "$(dirname "${BASH_SOURCE[0]:-$0}")/.." rev-parse --show-toplevel)
COMPOSE_FILE="$REPO_ROOT/docker-compose.external-tests.yaml"

# Cleanup function to be called on script exit
cleanup() {
  echo "--- Cleaning up services for profile '$PROFILE' ---"
  # Stops and removes containers, networks, and volumes.
  # Using --profile ensures we only affect the relevant service.
  docker compose -f "$COMPOSE_FILE" --profile "$PROFILE" down --remove-orphans -v
}

# Trap EXIT signal to ensure cleanup happens regardless of script outcome
trap cleanup EXIT

# Use `docker compose run` for this one-off task.
# DOCKER_BUILD_TARGET is used by docker-compose.yml to select the build stage.
# --build: Ensures the image is up-to-date.
# --no-TTY: Disables pseudo-TTY allocation, preventing hangs in scripts.
# The command returns the exit code of the container, so set -e handles failures.
export DOCKER_BUILD_TARGET="$TARGET"
docker compose -f "$COMPOSE_FILE" \
  --profile "$PROFILE" \
  run \
  --build \
  ${EXTRA_ARGS} \
  "$PROFILE"


# The `run` command leaves behind a stopped container, which is perfect for
# artifact extraction. The `trap` will clean it up afterward.
CONTAINER_ID=$(docker compose -f "$COMPOSE_FILE" --profile "$PROFILE" ps -q "$PROFILE")

if [[ -n "$CONTAINER_ID" ]]; then
  echo "--- Copying artifacts from container: $CONTAINER_ID"

  mapfile -t ARTIFACTS < <(
    docker inspect \
      --format '{{ range $k,$v := .Config.Labels }}{{ if (hasPrefix $k "external-test.artifact.") }}{{ $v }} {{ end }}{{ end }}' \
      "$CONTAINER_ID"
  )

  if [[ ${#ARTIFACTS[@]} -eq 0 ]]; then
    echo "No 'external-test.artifact.*' labels found. No artifacts to copy."
  fi

  for ENTRY in "${ARTIFACTS[@]}"; do
    # Split "src::dst" (or just "src")
    IFS="::" read -r SRC DST <<<"$ENTRY"
    DST=${DST:-$(basename "$SRC")}
    HOST_PATH="$REPO_ROOT/external-tests/$PROFILE/$DST"

    # Ensure the destination directory on the host exists
    mkdir -p "$(dirname "$HOST_PATH")"

    echo "Copying '$SRC' -> '$HOST_PATH'"
    # Suppress "No such container:path" errors, but warn the user.
    if ! docker cp "$CONTAINER_ID":"$SRC" "$HOST_PATH" 2>/dev/null; then
      echo "Warning: Could not copy artifact '$SRC'. It may not have been created."
    fi
  done
fi

# The 'trap cleanup EXIT' will be executed automatically when the script exits.
