FROM open5gs-base AS builder
FROM alpine:3.18

WORKDIR /
RUN mkdir open5gs
WORKDIR /open5gs
RUN mkdir -p install/bin install/lib install/etc install/tls

COPY --from=builder /open5gs/install/bin/open5gs-pcfd ./install/bin/
COPY --from=builder /open5gs/install/lib/lib-pcf/* ./install/lib/
COPY --from=builder /open5gs/install/etc/open5gs/tls/pcf* ./install/tls/
COPY --from=builder /open5gs/install/etc/open5gs/tls/ca.crt ./install/tls/
COPY --from=builder /open5gs/install/etc/open5gs/pcf.yaml ./install/etc/

RUN ldconfig /open5gs/install/bin/open5gs-pcfd

VOLUME [ "/open5gs/install/etc" ]
WORKDIR /open5gs/install/bin