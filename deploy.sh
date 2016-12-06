#!/bin/bash

export SSHPASS=$DEPLOY_PASS
IMAGE=$(find tmp/deploy/images |grep sdimg |head -n1)
REMOTE=builds/$(date +%s)_diaspberry-${TRAVIS_BRANCH}.img

if [[ "$MACHINE" -eq "qemuarm" ]]; then
  IMAGE=$(find tmp/deploy/images |grep '.rootfs.ext4' |head -n1)
  REMOTE=builds/$(date +%s)_diaspberry-${TRAVIS_BRANCH}.rootfs.ext4
fi

echo "Upload ${IMAGE} to ${REMOTE}"
sshpass -e scp -oStrictHostKeyChecking=no \
  $IMAGE $DEPLOY_USER@$DEPLOY_HOST:$REMOTE

echo "Update symbolic link on public directory"
sshpass -e ssh -oStrictHostKeyChecking=no \
  $DEPLOY_USER@$DEPLOY_HOST "ln -fs ../${REMOTE} builds/latest-${TRAVIS_BRANCH}"
