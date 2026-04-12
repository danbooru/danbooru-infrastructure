#!/bin/bash

set -euxo pipefail

CONTEXT=${1:-danbooru-production}
kubectl --context $CONTEXT patch service/danbooru -p '{ "spec": { "selector": { "app": "downbooru" }}}'
kubectl --context $CONTEXT patch service/betabooru -p '{ "spec": { "selector": { "app": "downbooru" }}}'
kubectl --context $CONTEXT patch service/safebooru -p '{ "spec": { "selector": { "app": "downbooru" }}}'
