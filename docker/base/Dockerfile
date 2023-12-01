FROM alpine:3.18 as builder

RUN apk update
RUN apk --no-cache add \
    alpine-sdk \
    flex bison lksctp-tools-dev git cmake gnutls-dev libgcrypt-dev bash sudo linux-headers libidn-dev \
    mongo-c-driver-dev bsd-compat-headers libbson-dev yaml-dev nghttp2-dev libmicrohttpd-dev curl-dev libtins-dev talloc-dev meson

RUN apk --no-cache add nodejs npm

WORKDIR /
RUN git clone https://github.com/open5gs/open5gs && cd open5gs

WORKDIR /open5gs
RUN meson build --prefix=`pwd`/install && \
    ninja -C build && \
    cd build && \
    ninja install