#!/bin/bash

export SERVER="${SERVER_ROOT}/TerrariaServer.exe"
export VERSIONCHECK="${SERVER_ROOT}/check.TmodloaderServer"

if [ ! -e "${SERVER}" ] || [ ! -e "${VERSIONCHECK}" ] || [ -n "${FORCE_REDOWNLOAD}" ]; then
  cd "${SERVER_ROOT}" || exit 1
  rm -rf "${SERVER_ROOT:?}"/*
  wget -q http://terraria.org/server/terraria-server-"${SERVER_VERSION}".zip -O /tmp/"${SERVER_ZIP}"
  bsdtar --strip-components=2 -xvf /tmp/"${SERVER_ZIP}" "${SERVER_VERSION}"/Linux/*
  rm "/tmp/${SERVER_ZIP}"
  cd "${SERVER_ROOT}" || exit 1
  chmod a+rw ./*
  chmod a+x TerrariaServer*
  wget -q https://github.com/tModLoader/tModLoader/releases/download/v"${TMODLOADER_VERSION}"/tModLoader.Linux.v"${TMODLOADER_VERSION}".zip -O /tmp/"${TMODLOADER_ZIP}"
  cd "${SERVER_ROOT}" || exit 1
  bsdtar -xvf /tmp/"${TMODLOADER_ZIP}"
  rm  /tmp/"${TMODLOADER_ZIP}"
  cd "${SERVER_ROOT}" || exit 1
  chmod a+rw ./*
  chmod a+x tModLoaderServer* 
  touch "${VERSIONCHECK}"
  chown -R terraria:terraria "${SERVER_ROOT}"
fi
#exec gosu terraria /launch.sh "$@"
exec /run-enablemodTmodloader.sh "$@"
