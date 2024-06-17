FROM golang:1.20-alpine as builder
WORKDIR /app
COPY . /app

RUN apk update && \
    apk add --no-cache bash && \
    apk add --no-cache git && \
    rm -rf /var/cache/apk/* /tmp/* /var/tmp/* $HOME/.cache

RUN /app/.tools/build.sh default

FROM alpine:3.9 
RUN apk add ca-certificates
WORKDIR /app

COPY --from=builder /app/.build/devops-test /app

CMD ["./devops-test"]