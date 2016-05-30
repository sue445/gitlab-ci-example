#!/bin/bash -xe

CAP_STAGE=$1

# CAP_STAGEが設定されていなければstagingにデプロイ
if [ -z "${CAP_STAGE}" ]; then
  CAP_STAGE="staging"
fi

bundle exec cap ${CAP_STAGE}

exit 0
