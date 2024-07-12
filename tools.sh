#!/bin/bash
set -ex

MONGOSH_VERSION=2.2.12

PROJECT_DIR=$(cd `dirname $0`; pwd)

cd ${PROJECT_DIR}/opt/download/public || exit 1

for arch in x64 arm64 ppc64le s390x; do
    wget --no-clobber https://downloads.mongodb.com/compass/mongosh-${MONGOSH_VERSION}-linux-${arch}.tgz
done