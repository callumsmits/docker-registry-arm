# Compile of registry binaries
FROM arm32v6/golang:1.10.4-alpine3.8 as builder

ENV DISTRIBUTION_DIR /go/src/github.com/docker/distribution
ENV DOCKER_BUILDTAGS include_oss include_gcs

ARG GOOS=linux
ARG GOARCH=arm
ARG GOARM=6

RUN apk update && apk add git make

ARG VERSION=master
RUN git clone -b $VERSION https://github.com/docker/distribution.git $DISTRIBUTION_DIR

WORKDIR $DISTRIBUTION_DIR

RUN make PREFIX=/go clean binaries


# Build a minimal distribution container
FROM alpine:3.8

RUN apk update && apk add --no-cache ca-certificates apache2-utils

COPY --from=builder /go/src/github.com/docker/distribution/bin/registry /bin/registry
COPY config-example.yml /etc/docker/registry/config.yml

VOLUME ["/var/lib/registry"]
EXPOSE 5000
ENTRYPOINT ["/bin/registry"]
CMD ["serve", "/etc/docker/registry/config.yml"]
