#!/usr/bin/env bash

set -euo pipefail

cd "$(dirname "$0")"/..

requirements=requirements.txt

{
cat << EOF
# Install required python packages using pip:
# pip install -r requirements.txt
EOF

./pip.sh freeze
} > "$requirements"
