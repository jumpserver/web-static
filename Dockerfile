FROM debian:bullseye-slim
ARG TARGETARCH

LABEL org.opencontainers.image.source https://github.com/jumpserver/web-static

ARG APT_MIRROR=http://mirrors.ustc.edu.cn
RUN --mount=type=cache,target=/var/cache/apt,sharing=locked,id=web \
    sed -i "s@http://.*.debian.org@${APT_MIRROR}@g" /etc/apt/sources.list \
    && rm -f /etc/cron.daily/apt-compat \
    && ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && apt-get update \
    && apt-get install -y --no-install-recommends wget ca-certificates \
    && echo "no" | dpkg-reconfigure dash \
    && rm -rf /var/lib/apt/lists/*

ARG DOWNLOAD_URL=https://download.jumpserver.org
ARG PLAY_VERSION=1.1.0-1

WORKDIR /opt/player
RUN set -ex \
    && wget -q ${DOWNLOAD_URL}/public/glyptodon-enterprise-player-${PLAY_VERSION}.tar.gz \
    && tar -xf glyptodon-enterprise-player-${PLAY_VERSION}.tar.gz -C /opt/player --strip-components 1 \
    && rm -f glyptodon-enterprise-player-${PLAY_VERSION}.tar.gz

WORKDIR /opt/download/applets

ARG PYTHON_VERSION=3.11.6
RUN set -ex \
    && wget -q https://www.python.org/ftp/python/${PYTHON_VERSION}/python-${PYTHON_VERSION}-amd64.exe

ARG CHROME_VERSION=118.0.5993.118
ARG CHROME_DRIVER_VERSION=118.0.5993.70
RUN set -ex \
    && wget -q https://github.com/wojiushixiaobai/Chrome-Portable-Win64/releases/download/${CHROME_DRIVER_VERSION}/chromedriver-win64.zip \
    && wget -q https://github.com/wojiushixiaobai/Chrome-Portable-Win64/releases/download/${CHROME_VERSION}/chrome-win.zip

ARG DBEAVER_VERSION=22.3.4
RUN set -ex \
    && wget -q ${DOWNLOAD_URL}/public/dbeaver-ce-${DBEAVER_VERSION}-x86_64-setup.exe \
    && wget -qO dbeaver-patch.msi ${DOWNLOAD_URL}/public/dbeaver-patch-${DBEAVER_VERSION}-x86_64-setup.msi

ARG TINKER_VERSION=v0.1.3
RUN set -ex \
    && wget -qO Tinker_Installer.exe ${DOWNLOAD_URL}/public/Tinker_Installer_${TINKER_VERSION}.exe

WORKDIR /opt/download/public
ARG MRD_VERSION=10.6.7
RUN set -ex \
    && wget -q ${DOWNLOAD_URL}/public/Microsoft_Remote_Desktop_${MRD_VERSION}_installer.pkg

ARG VIDEO_PLAYER_VERSION=0.1.9
RUN set -ex \
    && wget -qO JumpServer-Video-Player.dmg https://github.com/jumpserver/VideoPlayer/releases/download/v0.1.9/JumpServer.Video.Player-${VIDEO_PLAYER_VERSION}.dmg \
    && wget -qO JumpServer-Video-Player.exe https://github.com/jumpserver/VideoPlayer/releases/download/v0.1.9/JumpServer.Video.Player.Setup.${VIDEO_PLAYER_VERSION}.exe

ARG OPENSSH_VERSION=v9.4.0.0
RUN set -ex \
    && wget -qO OpenSSH-Win64.msi https://github.com/PowerShell/Win32-OpenSSH/releases/download/${OPENSSH_VERSION}p1-Beta/OpenSSH-Win64-${OPENSSH_VERSION}.msi

ARG Client_VERSION=v2.1.0
RUN set -ex \
    && wget -qO JumpServer-Client-Installer-x86_64.msi https://github.com/jumpserver/clients/releases/download/${Client_VERSION}/JumpServer-Client-Installer-win-${Client_VERSION}-x64.msi \
    && wget -qO JumpServer-Client-Installer-x86_64.exe https://github.com/jumpserver/clients/releases/download/${Client_VERSION}/JumpServer-Client-Installer-win-${Client_VERSION}-x64.exe \
    && wget -qO JumpServer-Client-Installer-amd64.dmg https://github.com/jumpserver/clients/releases/download/${Client_VERSION}/JumpServer-Client-Installer-mac-${Client_VERSION}-x64.dmg \
    && wget -qO JumpServer-Client-Installer-arm64.dmg https://github.com/jumpserver/clients/releases/download/${Client_VERSION}/JumpServer-Client-Installer-mac-${Client_VERSION}-arm64.dmg \
    && wget -qO JumpServer-Client-Installer-amd64.deb https://github.com/jumpserver/clients/releases/download/${Client_VERSION}/JumpServer-Client-Installer-linux-${Client_VERSION}-amd64.deb \
    && wget -qO JumpServer-Client-Installer-arm64.deb https://github.com/jumpserver/clients/releases/download/${Client_VERSION}/JumpServer-Client-Installer-linux-${Client_VERSION}-arm64.deb