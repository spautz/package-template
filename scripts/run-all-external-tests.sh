#!/usr/bin/env bash

# Run every external test sequentially using scripts/run-external-test.sh.
# Swap the for-loop for an xargs parallel variant when you want to run in
# parallel (see comments below).

set -euo pipefail

REPO_ROOT=$(git -C "$(dirname "${BASH_SOURCE[0]:-$0}")/.." rev-parse --show-toplevel)
cd "$REPO_ROOT"

# Ensure local packages are published & every external test dir is up-to-date
./scripts/update-external-tests.sh

# Discover every directory directly under external-tests/ and trim trailing slash
EXTERNAL_TESTS=( $(find external-tests -mindepth 1 -maxdepth 1 -type d -printf "%f\n" | sort) )

for PROFILE in "${EXTERNAL_TESTS[@]}"; do
  echo "Running external test: $PROFILE"
  ./scripts/run-external-test.sh "$PROFILE"
  echo "Finished external test: $PROFILE"
  echo "-------------------------------------------------------------"
  echo
done

# Uncomment the following line to run tests in parallel (replace N with $(nproc))
# printf "%s\n" "${EXTERNAL_TESTS[@]}" | xargs -P"$(nproc)" -n1 ./scripts/run-external-test.sh 