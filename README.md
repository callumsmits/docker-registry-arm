# Docker registry ARMv6

Docker registry build for Raspberry PI zero and above

This package is based on official [docker registry](https://github.com/docker/distribution-library-image/)

## How to use 

### Docker 

```shell
$ docker run -d -p 5000:5000 --restart=always --name registry callumsmits/docker-registry-arm32v6
```

For more options see https://github.com/docker/docker.github.io/blob/master/registry/deploying.md

### Building

```shell
$ git clone git@github.com:callumsmits/docker-registry-arm.git
$ cd docker-registry-arm
$ docker build -t my/registry .
$ docker run -d -p 5000:5000 --restart always my/registry
```

## Compatibility

This package and docker image have been tested on Raspberry Pi Zero and 3, running in
docker or kubernetes.
