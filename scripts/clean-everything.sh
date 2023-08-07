#!/usr/bin/env bash

# Fail if anything in here fails
set -e

# This script runs from the project root
cd "$(dirname "$0")/.."

source ./scripts/helpers/helpers.sh

###################################################################################################
# Halt running processes and local servers

if command_exists killall; then
  run_command killall -v node || true
fi

if command_exists watchman; then
  run_command watchman watch-del-all
fi

##################################################################################################
# Clear caches

if [ -d "./node_modules/" ]; then
  run_command pnpm run clean
fi

if command_exists npm; then
  run_command "npm cache verify" || true
fi

if command_exists pnpm; then
  run_command "pnpm store prune" || true
fi

if command_exists yarn; then
  run_command "yarn cache clean --all" || true
fi

run_command "rm -rf
  $TMPDIR/react-*
  "

##################################################################################################
# Remove generated files

for DIRECTORY in '.' 'demos/*git' 'framework-tests/*' 'packages/*' ; do
  run_command "rm -rf
    $DIRECTORY/build/
    $DIRECTORY/coverage/
    $DIRECTORY/dist/
    $DIRECTORY/e2e-test-results/
    $DIRECTORY/legacy-types/
    $DIRECTORY/node_modules/
    $DIRECTORY/playwright-report/
    $DIRECTORY/storybook-static/
    $DIRECTORY/*.log*
    "
done

REMAINING_FILES=$(git clean -xdn | sed 's/Would remove /    /')
if [[ $REMAINING_FILES ]]; then
  echo "Ignored files left:"
  echo "$REMAINING_FILES"
fi;

###################################################################################################

echo "Environment reset completed"
