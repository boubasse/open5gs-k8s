FROM alpine:3.18

RUN apk update
RUN apk --no-cache add \
    alpine-sdk \
    flex bison lksctp-tools-dev git cmake gnutls-dev libgcrypt-dev bash sudo linux-headers libidn-dev \
    mongo-c-driver-dev bsd-compat-headers libbson-dev yaml-dev nghttp2-dev libmicrohttpd-dev curl-dev talloc-dev meson

RUN apk --no-cache add nodejs npm

WORKDIR /
RUN git clone https://github.com/open5gs/open5gs && cd open5gs

WORKDIR /open5gs
RUN meson build --prefix=`pwd`/install && \
    ninja -C build && \
    cd build && \
    ninja install

WORKDIR /open5gs/install

ENV NFS amf bsf nssf udm upf ausf nrf pcf smf udr scp sepp

RUN for NF in ${NFS}; \
    do mkdir -p lib/lib-${NF}; \
    ldd bin/open5gs-${NF}d | grep "=> /" | awk '{print $3}' | xargs -I '{}' cp -v '{}' lib/lib-${NF}/; done