#!/bin/bash

set -euxo pipefail

#git tag -a -m "user deployed $(git rev-parse production) to production"
#git push

deploy() {
  kubectl rollout restart deploy/"$@"
  kubectl rollout status deploy/"$@"
}

deploy downbooru
deploy danbooru-cron
deploy danbooru-jobs
deploy danbooru
