FROM open5gs-base AS builder
FROM alpine:3.18

WORKDIR /
RUN mkdir open5gs
WORKDIR /open5gs
RUN mkdir -p install/bin install/lib install/etc/open5gs install/etc/open5gs/tls install/var/log/open5gs

COPY --from=builder /open5gs/install/bin/open5gs-pcfd ./install/bin/
COPY --from=builder /open5gs/install/lib/lib-pcf/* ./install/lib/
COPY --from=builder /open5gs/install/etc/open5gs/tls/pcf* ./install/etc/open5gs/tls/
COPY --from=builder /open5gs/install/etc/open5gs/tls/ca.crt ./install/etc/open5gs/tls/
COPY --from=builder /open5gs/install/etc/open5gs/pcf.yaml ./install/etc/open5gs/

RUN ldconfig /open5gs/install/bin/open5gs-pcfd

VOLUME [ "/open5gs/install/etc/open5gs" ]
VOLUME [ "/open5gs/install/var/log/open5gs" ]

WORKDIR /open5gs/install/bin