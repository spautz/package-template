#!/usr/bin/env bash

THIS_SCRIPT_NAME=$(basename "$0")
echo "### Begin ${THIS_SCRIPT_NAME}"

# Fail if anything in here fails
set -e
# Run from the repo root
pushd "$(dirname -- "${BASH_SOURCE[0]:-$0}")/.."

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

run_command "rm -rf
  $TMPDIR/react-*
  .pnpm-debug.log
  npm-debug.log
  yarn-debug.log
  yarn-error.log
  "

##################################################################################################
# Remove generated files


for DIRECTORY in framework-tests/*/ ; do
  pushd $DIRECTORY
  if [ -d "./node_modules/" ]; then
    run_command "pnpm run yalc-teardown"
  fi
  popd
done

for DIRECTORY in '.' 'demos/*' 'framework-tests/*' 'packages/*' ; do
  run_command "rm -rf
    $DIRECTORY/.yalc/
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

popd
echo "### End ${THIS_SCRIPT_NAME}"
