# Docker registry ARM build

This package is based on [old and unmaintained project](https://github.com/vdavy/distribution-library-image).

## Content

* [The main idea](#the-main-idea)
* [How it works](#how-it-works)
* [How to use](#how-to-use)
    * [Docker](#docker)
    * [Custom build](#custom-build)
* [Compatibility](#compatibility)

## The main idea

This package was developed for running docker registry on Raspberry PI 2/3. On docker hub we can found a few arm/rpi 
build of docker registry but a many of this packages not work or is too outdated. This is reason why this package was
created.

## How it works

This package complie oficial [docker/distribution pacakge](https://github.com/docker/distribution) on Raspberry PI with 
[scaleway/golang:armhf-latest](https://hub.docker.com/r/scaleway/golang/) docker image and build registry on 
[resin/rpi-raspbian:jessie](https://hub.docker.com/r/resin/rpi-raspbian/) image.

Steps: 

1. Package clone [docker/distribution pacakge](https://github.com/docker/distribution) from github
2. Replace original [Dockerfile](https://github.com/docker/distribution/blob/master/Dockerfile) by this 
[Dockerfile.distribution](https://github.com/Budry/docker-registry-arm/blob/master/Dockerfile.distribution) (Dockerfiles 
should be same, only FROM directive is different)
3. Build [docker/distribution registry](https://github.com/docker/distribution/tree/master/registry) with `make`
4. Build a new docker registry by steps from [official repository](https://github.com/docker/distribution-library-image)
5. Done!

## How to use 

### Docker 

You can use my official build of this package with name [budry/registry-arm](https://hub.docker.com/r/budry/registry-arm/)

```shell
$ docker run -d -p 5000:5000 --restart always budry/registry-arm
```

I trying update build of this package as soon as possible for each docker registry update, but when you need more actual
 version I recommend you [custom build](#custom-build)  

### Custom build

Or you can use custom build on your ARM (Raspberry PI) device. 

**IMPORTANT NOTE: Build must be only on ARM device. On x86/x64 CPU not work!**

```shell
$ git clone git@github.com:Budry/docker-registry-arm.git
$ cd docker-registry-arm
$ sh update.sh master
$ docker build -t my/registry .
$ docker run -d -p 5000:5000 --restart always my/registry
```

In this case you can specific docker version by first argument for `update.sh`. If you use `master` your registry will
be actual

## Compatibility

This package and docker image if tested od Raspberry PI 2 and Raspberry PI 3  