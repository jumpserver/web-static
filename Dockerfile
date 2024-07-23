FROM alpine:3.20.1

WORKDIR /tmp

COPY . .

RUN set -ex \
    && apk add --no-cache bash \
    && bash ./prepare.sh
