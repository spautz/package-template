#!/usr/bin/env bash

THIS_SCRIPT_NAME=$(basename "$0")
echo "### Begin ${THIS_SCRIPT_NAME}"

# Fail if anything in here fails
set -e
# Run from the repo root
pushd "$(dirname -- "${BASH_SOURCE[0]:-$0}")/.."

source ./scripts/helpers/helpers.sh

###################################################################################################
# `build-workspace.sh` ensures that all packages and demos are up-to-date and passing.
# This covers everything except the external-tests.

./scripts/check-environment.sh

pnpm_or_bun install --frozen-lockfile --prefer-offline

# Run all normal commands and all CI commands. This is overkill and duplicates a lot of work,
# but also helps catch any intermittent errors. Suitable for running before lunch or teatime.
pnpm_or_bun run packages:all
pnpm_or_bun run all:all
pnpm_or_bun run packages:all:ci
pnpm_or_bun run all:ci

###################################################################################################

popd
echo "### End ${THIS_SCRIPT_NAME}"
