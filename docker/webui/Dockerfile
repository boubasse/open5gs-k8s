FROM open5gs-base AS builder
FROM node:lts-alpine3.18

WORKDIR /

COPY --from=builder /open5gs/webui ./webui

WORKDIR /webui

RUN npm ci
CMD [ "npm run dev" ]