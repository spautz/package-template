#!/usr/bin/env bash

# This runs the checks for every package and demo app.

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
# Main body

./scripts/check-environment.sh

pnpm install --frozen-lockfile --prefer-offline

# Run all normal commands and all CI commands. This is overkill and duplicates a lot of work,
# but also helps catch any intermittent errors. Suitable for running before lunch or teatime.
pnpm run clean
pnpm run packages:all
pnpm run packages:all:ci

pnpm run clean
pnpm run all
pnpm run all:ci

pnpm run clean
pnpm run all:all

# Also ensure that packing works: AreTheTypesWrong might not run outside of pack
for DIRECTORY in packages/* ; do
  pushd $DIRECTORY;
  run_command "pnpm pack" || exit 1;
  popd;
done


###################################################################################################
# Standard teardown for all scripts

popd
echo "### End ${THIS_SCRIPT_NAME}"
