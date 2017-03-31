#!/usr/bin/env sh

help() {
  echo "Usage: ${0} <image> <tag>"
}

if [ -z "$1" ] ; then
        echo "Missing image name"
        help
        exit 1
fi

if [ -z "$2" ] ; then
        echo "Missing image tag"
        help
        exit 1
fi

BASEDIR="$(dirname $0)"

echo "Run update.sh ${2}"
sh ${BASEDIR}/update.sh $2

echo "Run docker build -t ${1}:${2} ${BASEDIR}"
docker build -t ${1}:${2} ${BASEDIR}

echo "Update image on docker HUB"
docker push docker.io/${1}:${2}
