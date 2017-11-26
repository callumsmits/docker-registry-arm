#!/bin/bash

# Syntax: build.sh [-t imagetag] [version]

set -e

if [ "$1" == "-t" ]; then
  shift
  IMAGE_TAG=$1
  shift
else
  IMAGE_TAG=my/registry
fi

if [ "$1" == "" ]; then
  VERSION=$(cat TAG)
else
  VERSION=$1
fi

echo Using version $VERSION

# cd to the current directory so the script can be run from anywhere.
cd `dirname $0`

docker build --build-arg VERSION=$VERSION -t $IMAGE_TAG .

# Test it
docker run --rm -it $IMAGE_TAG --version