FROM open5gs-base AS builder
FROM alpine:3.18

WORKDIR /
RUN mkdir open5gs
WORKDIR /open5gs
RUN mkdir -p install/bin install/lib install/etc install/etc/tls install/log

COPY --from=builder /open5gs/install/bin/open5gs-nrfd ./install/bin/
COPY --from=builder /open5gs/install/lib/lib-nrf/* ./install/lib/
COPY --from=builder /open5gs/install/etc/open5gs/tls/nrf* ./install/etc/tls/
COPY --from=builder /open5gs/install/etc/open5gs/tls/ca.crt ./install/etc/tls/
COPY --from=builder /open5gs/install/etc/open5gs/nrf.yaml ./install/etc/

RUN ldconfig /open5gs/install/bin/open5gs-nrfd

VOLUME [ "/open5gs/install/etc", "/open5gs/install/log" ]

WORKDIR /open5gs/install/bin