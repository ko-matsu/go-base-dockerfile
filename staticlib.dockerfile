FROM --platform=$TARGETPLATFORM golang:1.18.6-alpine3.15

ARG CFDGO_VERSION=v0.4.3
RUN apk update && apk add --no-cache alpine-sdk git cmake

WORKDIR /workspace
RUN git clone https://github.com/cryptogarageinc/cfd-go -b $CFDGO_VERSION --depth 1 \
    && cd cfd-go \
    && ./tools/simple_build.sh \
    && go build && ./go_test.sh && go clean -testcache \
    && cd build && make install && cd .. \
    && cd .. && rm -rf cfd-go
