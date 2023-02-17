#!/bin/bash

echo "Setting docker repo..."
docker login -u $DOCKER_USERNAME -p $DOCKER_PASSWORD

echo "Setting up build variables..."
GIT_COMMIT=$(git rev-list -1 HEAD)

echo "Setting up buildx..."
docker buildx version
docker run --rm --privileged multiarch/qemu-user-static --reset -p yes
docker buildx create

echo "Building..."
docker buildx build \
--platform linux/amd64 \
-t cube8021/docker-buildx:${DRONE_BUILD_NUMBER} \
-t cube8021/docker-buildx:latest \
--cache-from cube8021/docker-buildx:latest \
--build-arg GIT_COMMIT=${DRONE_COMMIT} \
--build-arg GIT_BRANCH=${DRONE_BRANCH} \
--push -f Dockerfile .
