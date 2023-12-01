FROM open5gs-base AS builder
FROM alpine:3.18

WORKDIR /
RUN mkdir open5gs
WORKDIR /open5gs
RUN mkdir -p install/bin install/lib install/etc/open5gs install/etc/open5gs/tls

COPY --from=builder /open5gs/install/bin/open5gs-bsfd ./install/bin/
COPY --from=builder /open5gs/install/lib/lib-bsf/* ./install/lib/
COPY --from=builder /open5gs/install/etc/open5gs/tls/bsf* ./install/etc/open5gs/tls/
COPY --from=builder /open5gs/install/etc/open5gs/tls/ca.crt ./install/etc/open5gs/tls/
COPY --from=builder /open5gs/install/etc/open5gs/bsf.yaml ./install/etc/open5gs/

RUN ldconfig /open5gs/install/bin/open5gs-bsfd

VOLUME [ "/open5gs/install/etc" ]
WORKDIR /open5gs/install/bin