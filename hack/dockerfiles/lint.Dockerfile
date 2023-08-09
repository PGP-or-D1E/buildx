# syntax=docker/dockerfile:1.0-experimental

FROM golang:1.20.7-alpine
RUN apk add --no-cache git yamllint
RUN go get -u gopkg.in/alecthomas/gometalinter.v1 \
  && mv /go/bin/gometalinter.v1 /go/bin/gometalinter \
  && gometalinter --install
WORKDIR /go/src/github.com/docker/buildx
RUN --mount=target=/go/src/github.com/docker/buildx \
  gometalinter --config=gometalinter.json ./...
RUN --mount=target=/go/src/github.com/docker/buildx \
  yamllint -c .yamllint.yml --strict .
