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

echo "Run update.sh ${2}"
sh update.sh $2

echo "Run docker build -t ${2}:${1} ."
docker build -t ${1}:${2} .

echo "Update image on docker HUB"
docker push ${1}:${2}