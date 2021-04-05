#!/usr/bin/env bash

# https://console.online.net/en/api/
# https://registry.terraform.io/providers/hashicorp/external/latest/docs/data-sources/data_source

set -euo pipefail

AUTHORIZATION="Authorization: Bearer $SCALEWAY_DEDIBOX_API_TOKEN"

if [[ "$1" == "server" ]]; then
  curl -s -H "$AUTHORIZATION" "https://api.online.net/api/v1/server/$2" |
    jq '{ id: .id | tostring, hostname, offer, ip: .ip[0].address }'
else
  exit 1
fi
