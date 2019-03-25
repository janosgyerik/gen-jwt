#!/usr/bin/env bash

set -euo pipefail

cd "$(dirname "$0")"/..

venv=./venv
test -d "$venv" || python3 -mvenv "$venv"

test -f "$venv/bin/activate" || {
    rm -fr "$venv"
    python3 -mvenv "$venv" --without-pip
    . "$venv/bin/activate"
    curl -s https://bootstrap.pypa.io/get-pip.py | python
}

requirements=requirements.txt
test -f "$requirements" && ./pip.sh install -r "$requirements" || :
