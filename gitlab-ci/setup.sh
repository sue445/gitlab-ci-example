#!/bin/bash -xe

# Setup ssh key
mkdir -p -m 700 ~/.ssh

#########################
# 秘密鍵の内容をコンソールに出したくないので一時的に無効にする
set +x

# NOTE: SSH_PRIVATE_KEYはSettings -> Variablesで設定
echo -e "$SSH_PRIVATE_KEY" > ~/.ssh/id_rsa

set -x
#########################

chmod 600 ~/.ssh/id_rsa

cat << EOS > ~/.ssh/config
Host *
    StrictHostKeyChecking no

EOS

cp gitlab-ci/database.yml config/database.yml
cp gitlab-ci/redis.yml config/global/redis.yml
cp gitlab-ci/cache.yml config/global/cache.yml

bundle check --path=${BUNDLE_CACHE} || bundle install --path=${BUNDLE_CACHE} --jobs=2 --retry=3

bundle exec rake db:create
bundle exec rake db:migrate:reset
