#!/bin/bash
set -ex

PLAY_VERSION=1.1.0-1
PYTHON_VERSION=3.11.6
CHROME_VERSION=118.0.5993.118
CHROME_DRIVER_VERSION=118.0.5993.70
DBEAVER_VERSION=22.3.4
TINKER_VERSION=v0.1.6
MRD_VERSION=10.6.7
VIDEO_PLAYER_VERSION=0.1.9
OPENSSH_VERSION=v9.4.0.0
Client_VERSION=v2.1.3
MONGOSH_VERSION=2.2.12

DOWNLOAD_URL=https://download.jumpserver.org

PROJECT_DIR=$(cd `dirname $0`; pwd)
if [ -d "/opt/lina" ] && [ -d "/opt/luna" ]; then
    PROJECT_DIR=/
fi

cd ${PROJECT_DIR} || exit 1

mkdir -p ${PROJECT_DIR}/opt/player
cd ${PROJECT_DIR}/opt/player || exit 1
wget --no-clobber ${DOWNLOAD_URL}/public/glyptodon-enterprise-player-${PLAY_VERSION}.tar.gz
tar -xf glyptodon-enterprise-player-${PLAY_VERSION}.tar.gz -C ${PROJECT_DIR}/opt/player --strip-components 1
rm -f glyptodon-enterprise-player-${PLAY_VERSION}.tar.gz

mkdir -p ${PROJECT_DIR}/opt/download/applets
cd ${PROJECT_DIR}/opt/download/applets
wget --no-clobber -O chromedriver-${CHROME_DRIVER_VERSION}-win64.zip https://github.com/jumpserver-dev/Chrome-Portable-Win64/releases/download/${CHROME_DRIVER_VERSION}/chromedriver-win64.zip
wget --no-clobber -O chrome-${CHROME_VERSION}-win.zip https://github.com/jumpserver-dev/Chrome-Portable-Win64/releases/download/${CHROME_VERSION}/chrome-win.zip
wget --no-clobber https://www.python.org/ftp/python/${PYTHON_VERSION}/python-${PYTHON_VERSION}-amd64.exe
wget --no-clobber ${DOWNLOAD_URL}/public/dbeaver-ce-${DBEAVER_VERSION}-x86_64-setup.exe
wget --no-clobber ${DOWNLOAD_URL}/public/dbeaver-patch-${DBEAVER_VERSION}-x86_64-setup.msi
wget --no-clobber ${DOWNLOAD_URL}/public/Tinker_Installer_${TINKER_VERSION}.exe

mkdir -p ${PROJECT_DIR}/opt/download/public
cd ${PROJECT_DIR}/opt/download/public || exit 1
wget --no-clobber ${DOWNLOAD_URL}/public/Microsoft_Remote_Desktop_${MRD_VERSION}_installer.pkg
wget --no-clobber https://github.com/jumpserver/VideoPlayer/releases/download/v0.1.9/JumpServer.Video.Player-${VIDEO_PLAYER_VERSION}.dmg
wget --no-clobber https://github.com/jumpserver/VideoPlayer/releases/download/v0.1.9/JumpServer.Video.Player.Setup.${VIDEO_PLAYER_VERSION}.exe
wget --no-clobber https://github.com/PowerShell/Win32-OpenSSH/releases/download/${OPENSSH_VERSION}p1-Beta/OpenSSH-Win64-${OPENSSH_VERSION}.msi
wget --no-clobber https://github.com/jumpserver/clients/releases/download/${Client_VERSION}/JumpServer-Client-Installer-win-${Client_VERSION}-x64.msi
wget --no-clobber https://github.com/jumpserver/clients/releases/download/${Client_VERSION}/JumpServer-Client-Installer-win-${Client_VERSION}-x64.exe
wget --no-clobber https://github.com/jumpserver/clients/releases/download/${Client_VERSION}/JumpServer-Client-Installer-mac-${Client_VERSION}-x64.dmg
wget --no-clobber https://github.com/jumpserver/clients/releases/download/${Client_VERSION}/JumpServer-Client-Installer-mac-${Client_VERSION}-arm64.dmg
wget --no-clobber https://github.com/jumpserver/clients/releases/download/${Client_VERSION}/JumpServer-Client-Installer-linux-${Client_VERSION}-amd64.deb
wget --no-clobber https://github.com/jumpserver/clients/releases/download/${Client_VERSION}/JumpServer-Client-Installer-linux-${Client_VERSION}-arm64.deb

if [ "${USE_XPACK}" = "0" ]; then
    for arch in x64 arm64 ppc64le s390x; do
        wget --no-clobber https://downloads.mongodb.com/compass/mongosh-${MONGOSH_VERSION}-linux-${arch}.tgz
    done
fi