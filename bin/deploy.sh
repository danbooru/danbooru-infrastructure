#!/bin/bash

set -euxo pipefail

# git tag production-$(date -u +"%Y.%m.%d.%H%M%S-utc") -a -m "user deployed $(git rev-parse production) to production"
# git push

deploy() {
  kubectl rollout restart --context $CONTEXT deploy/"$@"
  kubectl rollout status --context $CONTEXT deploy/"$@"
}

CONTEXT=${1:-danbooru-production}

deploy downbooru
deploy danbooru-cron
deploy danbooru-jobs

if [[ "$CONTEXT" = "danbooru-production" ]]; then
  deploy devbooru
  deploy safebooru
fi

deploy danbooru
