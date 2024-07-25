FROM python:3.11-slim-bullseye AS stage-build
ARG TARGETARCH

ARG DEPENDENCIES="            \
        ca-certificates       \
        curl                  \
        wget                  \
        zip"

ARG APT_MIRROR=http://deb.debian.org
RUN --mount=type=cache,target=/var/cache/apt,sharing=locked \
    --mount=type=cache,target=/var/lib/apt,sharing=locked \
    set -ex \
    && rm -f /etc/apt/apt.conf.d/docker-clean \
    && echo 'Binary::apt::APT::Keep-Downloaded-Packages "true";' >/etc/apt/apt.conf.d/keep-cache \
    && sed -i "s@http://.*.debian.org@${APT_MIRROR}@g" /etc/apt/sources.list \
    && apt-get update \
    && apt-get -y install --no-install-recommends ${DEPENDENCIES} \
    && apt-get clean all \
    && echo "no" | dpkg-reconfigure dash

ARG CHECK_VERSION=v1.0.2
RUN set -ex \
    && wget https://github.com/jumpserver-dev/healthcheck/releases/download/${CHECK_VERSION}/check-${CHECK_VERSION}-linux-${TARGETARCH}.tar.gz \
    && tar -xf check-${CHECK_VERSION}-linux-${TARGETARCH}.tar.gz \
    && mv check /usr/local/bin/ \
    && chown root:root /usr/local/bin/check \
    && chmod 755 /usr/local/bin/check \
    && rm -f check-${CHECK_VERSION}-linux-${TARGETARCH}.tar.gz

WORKDIR /opt/applets

COPY requirements.txt ./requirements.txt

ARG PIP_MIRROR=https://pypi.org/simple
RUN set -ex \
    && mkdir pip_packages build \
    && pip config set global.index-url ${PIP_MIRROR} \
    && pip download \
          --only-binary=:all: --platform win_amd64 \
          --python-version 3.11.6 --abi cp311 \
          -d pip_packages -r requirements.txt -i${PIP_MIRROR} \
    && cp requirements.txt pip_packages \
    && zip -r pip_packages.zip pip_packages \
    && mv pip_packages.zip build


FROM alpine:3.20

COPY . .
RUN set -ex \
    && apk add --no-cache bash \
    && bash ./prepare.sh

COPY --from=stage-build /opt/applets/build /opt/applets
COPY --from=stage-build /usr/local/bin/check /usr/local/bin/check
