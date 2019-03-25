#!/usr/bin/env bash
#
# This file must be *sourced*, not executed
#

venv="$(dirname "${BASH_SOURCE[0]}")"/venv
[ -d "$venv" ] || ./setup.sh

. "$venv"/bin/activate
