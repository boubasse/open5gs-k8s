FROM open5gs-base AS builder
FROM alpine:3.18

WORKDIR /
RUN mkdir open5gs
WORKDIR /open5gs
RUN mkdir -p install/bin install/lib install/etc install/tls

COPY --from=builder /open5gs/install/bin/open5gs-udrd ./install/bin/
COPY --from=builder /open5gs/install/lib/lib-udr/* ./install/lib/
COPY --from=builder /open5gs/install/etc/open5gs/tls/udr* ./install/tls/
COPY --from=builder /open5gs/install/etc/open5gs/tls/ca.crt ./install/tls/
COPY --from=builder /open5gs/install/etc/open5gs/udr.yaml ./install/etc/

RUN ldconfig /open5gs/install/bin/open5gs-udrd

VOLUME [ "/open5gs/isntall/etc" ]
WORKDIR /open5gs/install/bin