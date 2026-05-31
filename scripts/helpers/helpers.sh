#!/usr/bin/env bash

###############################################################################

# Helpful functions for the other bash scripts in this directory.
# Note that this is not a runnable script itself.

command_exists() {
  # This check is based on https://unix.stackexchange.com/questions/85249/why-not-use-which-what-to-use-then
  command -v "$1" > /dev/null 2>&1
}

emit_warning() {
  local MESSAGE=$*

  echo "###"
  echo "###"
  echo "WARNING: ${MESSAGE}"
  echo "###"
  echo "###"
}

enable_trace() {
  export PS4='+ ${BASH_SOURCE##*/}:${LINENO}: '
  set -x
}

# This simply echoes and then runs a command. It's just an alternative to turning on echo globally (set -x)
# so that we get cleaner output.
run_command() {
  printf '+ '
  printf '%q ' "$@"
  printf '\n'
  "$@"
}

###############################################################################

# Automatically enable global tracing if `TRACE` is enabled
if [[ ${TRACE:-0} == 1 ]]; then
  enable_trace
fi
