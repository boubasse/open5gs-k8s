FROM open5gs-base AS builder
FROM alpine:3.18

WORKDIR /
RUN mkdir open5gs
WORKDIR /open5gs
RUN mkdir -p install/bin install/lib install/etc install/tls install/log install/hnet

COPY --from=builder /open5gs/install/bin/open5gs-udmd ./install/bin/
COPY --from=builder /open5gs/install/lib/lib-udm/* ./install/lib/
COPY --from=builder /open5gs/install/etc/open5gs/tls/udm* ./install/tls/
COPY --from=builder /open5gs/install/etc/open5gs/tls/ca.crt ./install/tls/
COPY --from=builder /open5gs/install/etc/open5gs/udm.yaml ./install/etc/
COPY --from=builder /open5gs/install/etc/open5gs/hnet/*.key ./install/hnet/

RUN ldconfig /open5gs/install/bin/open5gs-udmd

VOLUME [ "/open5gs/install/etc", "/open5gs/install/log" ]

WORKDIR /open5gs/install/bin