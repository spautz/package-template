#!/usr/bin/env bash

THIS_SCRIPT_NAME=$(basename "$0")
echo "### Begin ${THIS_SCRIPT_NAME}"

# Fail if anything in here fails
set -e
# Run from the repo root
pushd "$(dirname -- "${BASH_SOURCE[0]:-$0}")/.."

source ./scripts/helpers/helpers.sh

###################################################################################################
# Check versions of Node, pnpm, and any other tools required

./scripts/check-environment.sh

# Quick install to check lockfile status
run_command "pnpm install --frozen-lockfile --ignore-scripts --prefer-offline"

# This command checks that the workspace is *already* set up (i.e., no `prepare`)
run_command

###################################################################################################

popd
echo "### End ${THIS_SCRIPT_NAME}"
