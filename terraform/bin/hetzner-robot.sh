#!/usr/bin/env bash

# https://registry.terraform.io/providers/hashicorp/external/latest/docs/data-sources/data_source
# https://docs.hetzner.com/robot/dedicated-server/robot-interfaces/
# https://robot.your-server.de/doc/webservice/en.html
# https://robot.your-server.de/preferences/index

set -euo pipefail

if [[ "$1" == "server" ]]; then
  curl -s -u "$HETZNER_USERNAME:$HETZNER_PASSWORD" "https://robot-ws.your-server.de/server/$2" |
    jq '.server | { server_number: .server_number | tostring, server_name, server_ip, product, status, paid_until }'
else
  exit 1
fi
