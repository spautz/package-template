#!/usr/bin/env bash

THIS_SCRIPT_NAME=$(basename "$0")
echo "### Begin ${THIS_SCRIPT_NAME}"

# Fail if anything in here fails
set -e
# Run from the repo root
pushd "$(dirname -- "${BASH_SOURCE[0]:-$0}")/.."

source ./scripts/helpers/helpers.sh

###################################################################################################

./scripts/check-environment.sh

pnpm_or_bun install --frozen-lockfile --prefer-offline
pnpm_or_bun run publish:yalc

for DIRECTORY in external-tests/*/ ; do
  pushd $DIRECTORY
  echo "External-test checks for $DIRECTORY"

  run_command ./external-test.sh
  popd
done

###################################################################################################

popd
echo "### End ${THIS_SCRIPT_NAME}"
