FROM open5gs-base AS builder
FROM alpine:3.18

WORKDIR /
RUN mkdir open5gs
WORKDIR /open5gs
RUN mkdir -p install/bin install/lib install/etc install/etc/tls install/etc/hnet

COPY --from=builder /open5gs/install/bin/open5gs-udmd ./install/bin/
COPY --from=builder /open5gs/install/lib/lib-udm/* ./install/lib/
COPY --from=builder /open5gs/install/etc/open5gs/tls/udm* ./install/etc/tls/
COPY --from=builder /open5gs/install/etc/open5gs/tls/ca.crt ./install/etc/tls/
COPY --from=builder /open5gs/install/etc/open5gs/udm.yaml ./install/etc/
COPY --from=builder /open5gs/install/etc/open5gs/hnet/*.key ./install/etc/hnet/

RUN ldconfig /open5gs/install/bin/open5gs-udmd

VOLUME [ "/open5gs/install/etc" ]

WORKDIR /open5gs/install/bin