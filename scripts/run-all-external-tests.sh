#!/usr/bin/env bash

# This updates and runs checks for every external test.
# Usage: ./scripts/run-all-external-tests.sh [target] [--parallel]
# Example: ./scripts/run-all-external-tests.sh run-ci --parallel

###################################################################################################
# Standard setup for all scripts

THIS_SCRIPT_NAME=$(basename "$0")
echo "### Begin ${THIS_SCRIPT_NAME}"

# Fail if anything in here fails
set -euo pipefail

# Always run from the repo root
REPO_ROOT=$(git -C "$(dirname "${BASH_SOURCE[0]:-$0}")" rev-parse --show-toplevel)
pushd "$REPO_ROOT"

# shellcheck source=scripts/helpers/helpers.sh
source ./scripts/helpers/helpers.sh

###################################################################################################
# Usage and arguments

DOCKER_TARGET="default"
PARALLEL=false

show_usage() {
  echo "Usage: $0 [target] [--parallel] [-h|--help]"
  echo "  target        The target to run (default: default)."
  echo "  --parallel    Run external tests in parallel (faster but uses more resources)."
  echo "  -h, --help    Display this help message."
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --parallel)
      PARALLEL=true
      shift
      ;;
    -h|--help)
      show_usage
      exit 0
      ;;
    -*)
      echo "Unknown option: $1"
      show_usage
      exit 1
      ;;
    *)
      DOCKER_TARGET="$1"
      shift
      ;;
  esac
done

###################################################################################################
# Main body

# Ensure local packages are published & every external test dir is up-to-date
./scripts/update-external-tests.sh

# A safe way to get the list of external-test directories: this won't break if any have spaces in their names
mapfile -t EXTERNAL_TESTS < <(find external-tests -mindepth 1 -maxdepth 1 -type d -printf "%f\n" | sort)

if [ "$PARALLEL" = true ]; then
  echo "Running all external tests in parallel with target: $DOCKER_TARGET"
  printf "%s\n" "${EXTERNAL_TESTS[@]}" | xargs -P"$(nproc)" -I {} ./scripts/run-external-test.sh {} "$DOCKER_TARGET"
else
  echo "Running all external tests sequentially with target: $DOCKER_TARGET"
  for PROFILE in "${EXTERNAL_TESTS[@]}"; do
    echo "Running external test: $PROFILE ($DOCKER_TARGET)"
    ./scripts/run-external-test.sh "$PROFILE" "$DOCKER_TARGET"
    echo
  done
fi

###################################################################################################
# Standard teardown for all scripts

popd
echo "### End ${THIS_SCRIPT_NAME}"
