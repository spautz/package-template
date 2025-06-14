#!/usr/bin/env bash

# Run every external test using scripts/run-external-test.sh.
# Usage: ./scripts/run-all-external-tests.sh [target] [--parallel]
# Example: ./scripts/run-all-external-tests.sh run-ci --parallel

set -euo pipefail

TARGET="default"
PARALLEL=false

for arg in "$@"; do
  if [[ "$arg" == "--parallel" ]]; then
    PARALLEL=true
  elif [[ "$arg" != -* ]]; then
    TARGET="$arg"
  fi
done

REPO_ROOT=$(git -C "$(dirname "${BASH_SOURCE[0]:-$0}")/.." rev-parse --show-toplevel)
cd "$REPO_ROOT"

# Ensure local packages are published & every external test dir is up-to-date
./scripts/update-external-tests.sh

# Discover every directory directly under external-tests/ and trim trailing slash
EXTERNAL_TESTS=( $(find external-tests -mindepth 1 -maxdepth 1 -type d -printf "%f\n" | sort) )

if [ "$PARALLEL" = true ]; then
  echo "Running all external tests in parallel with target: $TARGET"
  printf "%s\n" "${EXTERNAL_TESTS[@]}" | xargs -P"$(nproc)" -I {} ./scripts/run-external-test.sh {} "$TARGET"
else
  echo "Running all external tests sequentially with target: $TARGET"
  for PROFILE in "${EXTERNAL_TESTS[@]}"; do
    echo "Running external test: $PROFILE"
    ./scripts/run-external-test.sh "$PROFILE" "$TARGET"
    echo "Finished external test: $PROFILE"
    echo "-------------------------------------------------------------"
    echo
  done
fi
