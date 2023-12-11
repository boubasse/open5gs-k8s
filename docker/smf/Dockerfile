FROM open5gs-base AS builder
FROM alpine:3.18

WORKDIR /
RUN mkdir open5gs
WORKDIR /open5gs
RUN mkdir -p install/bin install/lib install/etc install/etc/tls install/etc/freeDiameter

COPY --from=builder /open5gs/install/bin/open5gs-smfd ./install/bin/
COPY --from=builder /open5gs/install/lib/lib-smf/* ./install/lib/
COPY --from=builder /open5gs/install/etc/open5gs/tls/smf* ./install/etc/tls/
COPY --from=builder /open5gs/install/etc/open5gs/tls/ca.crt ./install/etc/tls/
COPY --from=builder /open5gs/install/etc/open5gs/smf.yaml ./install/etc/
COPY --from=builder /open5gs/install/etc/freeDiameter/smf.conf ./install/etc/freeDiameter/

RUN ldconfig /open5gs/install/bin/open5gs-smfd

VOLUME [ "/open5gs/install/etc" ]
WORKDIR /open5gs/install/bin
