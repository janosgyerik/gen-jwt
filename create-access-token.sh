#!/usr/bin/env bash

set -euo pipefail

cd "$(dirname "$0")"

if [[ $# != 3 ]]; then
    echo "usage: $0 app_id path_to_pem installation_id" >&2
    exit 1
fi

app_id=$1
path_to_pem=$2
installation_id=$3
token=$(./gen.sh "$app_id" "$path_to_pem")
echo "$token"

curl -s -X POST \
    -H "Authorization: Bearer $token" \
    -H "Accept: application/vnd.github.machine-man-preview+json" \
    "https://api.github.com/app/installations/$installation_id/access_tokens" \
| jq -r .token
