#!/bin/bash
set -ex

PLAY_VERSION=1.1.0-1
PYTHON_VERSION=3.11.6
CHROME_VERSION=118.0.5993.118
CHROME_DRIVER_VERSION=118.0.5993.70
DBEAVER_VERSION=22.3.4
TINKER_VERSION=v0.1.5
MRD_VERSION=10.6.7
VIDEO_PLAYER_VERSION=0.1.9
OPENSSH_VERSION=v9.4.0.0
Client_VERSION=v2.1.2

DOWNLOAD_URL=https://download.jumpserver.org

PROJECT_DIR=$(cd `dirname $0`; pwd)
cd ${PROJECT_DIR} || exit 1

mkdir -p ${PROJECT_DIR}/opt/player
cd ${PROJECT_DIR}/opt/player
wget -q ${DOWNLOAD_URL}/public/glyptodon-enterprise-player-${PLAY_VERSION}.tar.gz
tar -xf glyptodon-enterprise-player-${PLAY_VERSION}.tar.gz -C /opt/player --strip-components 1
rm -f glyptodon-enterprise-player-${PLAY_VERSION}.tar.gz

mkdir -p ${PROJECT_DIR}/opt/download/applets
cd ${PROJECT_DIR}/opt/download/applets
wget -q https://www.python.org/ftp/python/${PYTHON_VERSION}/python-${PYTHON_VERSION}-amd64.exe
wget -q https://github.com/jumpserver-dev/Chrome-Portable-Win64/releases/download/${CHROME_DRIVER_VERSION}/chromedriver-win64.zip
wget -q https://github.com/jumpserver-dev/Chrome-Portable-Win64/releases/download/${CHROME_VERSION}/chrome-win.zip
wget -q https://dbeaver.io/files/${DBEAVER_VERSION}/dbeaver-ce-${DBEAVER_VERSION}-x86_64-setup.exe
wget -qO dbeaver-patch.msi ${DOWNLOAD_URL}/public/dbeaver-patch-${DBEAVER_VERSION}-x86_64-setup.msi
wget -qO Tinker_Installer.exe ${DOWNLOAD_URL}/public/Tinker_Installer_${TINKER_VERSION}.exe

mkdir -p ${PROJECT_DIR}/opt/download/public
cd ${PROJECT_DIR}/opt/download/public
wget -q ${DOWNLOAD_URL}/public/Microsoft_Remote_Desktop_${MRD_VERSION}_installer.pkg
wget -qO JumpServer-Video-Player.dmg https://github.com/jumpserver/VideoPlayer/releases/download/v0.1.9/JumpServer.Video.Player-${VIDEO_PLAYER_VERSION}.dmg
wget -qO JumpServer-Video-Player.exe https://github.com/jumpserver/VideoPlayer/releases/download/v0.1.9/JumpServer.Video.Player.Setup.${VIDEO_PLAYER_VERSION}.exe
wget -qO OpenSSH-Win64.msi https://github.com/PowerShell/Win32-OpenSSH/releases/download/${OPENSSH_VERSION}p1-Beta/OpenSSH-Win64-${OPENSSH_VERSION}.msi
wget -qO JumpServer-Client-Installer-x86_64.msi https://github.com/jumpserver/clients/releases/download/${Client_VERSION}/JumpServer-Client-Installer-win-${Client_VERSION}-x64.msi
wget -qO JumpServer-Client-Installer-x86_64.exe https://github.com/jumpserver/clients/releases/download/${Client_VERSION}/JumpServer-Client-Installer-win-${Client_VERSION}-x64.exe
wget -qO JumpServer-Client-Installer-amd64.dmg https://github.com/jumpserver/clients/releases/download/${Client_VERSION}/JumpServer-Client-Installer-mac-${Client_VERSION}-x64.dmg
wget -qO JumpServer-Client-Installer-arm64.dmg https://github.com/jumpserver/clients/releases/download/${Client_VERSION}/JumpServer-Client-Installer-mac-${Client_VERSION}-arm64.dmg
wget -qO JumpServer-Client-Installer-amd64.deb https://github.com/jumpserver/clients/releases/download/${Client_VERSION}/JumpServer-Client-Installer-linux-${Client_VERSION}-amd64.deb
wget -qO JumpServer-Client-Installer-arm64.deb https://github.com/jumpserver/clients/releases/download/${Client_VERSION}/JumpServer-Client-Installer-linux-${Client_VERSION}-arm64.deb

