#!/usr/bin/env sh

help() {
  echo "Usage: ${0} <image> [<tag> default from TAG file]"
}

if [ -z "$1" ] ; then
  echo "Missing image name"
  help
  exit 1
else   
    IMAGE_NAME=$1
fi

if [ -z "$2" ] ; then
  TAG=$(cat TAG)
else
  TAG=$2
fi


BASEDIR="$(dirname $0)"

echo "Run update.sh ${2}"
sh ${BASEDIR}/update.sh ${TAG}

if [ $? -ne 0 ]; then
  echo "Build failed"
  exit 1
fi

echo "Run docker build -t ${IMAGE_NAME}:${TAG} ${BASEDIR}"
docker build -t ${IMAGE_NAME}:${TAG} -t ${IMAGE_NAME}:latest ${BASEDIR}

echo "Update image on docker HUB"
docker push docker.io/${IMAGE_NAME}:${TAG}
