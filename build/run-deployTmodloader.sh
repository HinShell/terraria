#!/bin/bash

export SERVER="${SERVER_ROOT}/TerrariaServer.exe"
export VERSIONCHECK="${SERVER_ROOT}/check.TmodloaderServer"

if [ ! -e "${SERVER}" ] || [ ! -e "${VERSIONCHECK}" ] || [ -n "${FORCE_REDOWNLOAD}" ]; then
  cd "${SERVER_ROOT}" || exit 1
  rm -rf "${SERVER_ROOT:?}"/*
  wget -q http://terraria.org/server/terraria-server-"${SERVER_VERSION}".zip -O /tmp/"${SERVER_ZIP}"
  bsdtar --strip-components=2 -xvf /tmp/"${SERVER_ZIP}" "${SERVER_VERSION}"/Linux/*
  rm "/tmp/${SERVER_ZIP}"
  wget -q https://github.com/tModLoader/tModLoader/releases/download/v"${TMODLOADER_VERSION}"/tModLoader.Linux.v"${TMODLOADER_VERSION}".zip -O /tmp/"${TMODLOADER_ZIP}"
  bsdtar -xvf /tmp/"${TMODLOADER_ZIP}"
  rm  /tmp/"${TMODLOADER_ZIP}"
  chmod a+rw "${SERVER_ROOT:?}"/*
  chmod a+x "${SERVER_ROOT:?}"/TerrariaServer*
  chmod a+x "${SERVER_ROOT:?}"/tModLoaderServer* 
  touch "${VERSIONCHECK}"
  chown -R terraria:terraria "${SERVER_ROOT}"
fi
exec /run-enablemodTmodloader.sh "$@"
