#!/usr/bin/env bash

set -euo pipefail

cd "$(dirname "$0")"

. venv/bin/activate
python ./gen.py "$@"
