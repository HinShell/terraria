#!/bin/bash

export SERVER="${SERVER_ROOT}/TerrariaServer.exe"
export VERSIONCHECK="${SERVER_ROOT}/check.VanillaServer"

if [ ! -e "${SERVER}" ] || [ ! -e "${VERSIONCHECK}" ] || [ -n "${FORCE_REDOWNLOAD}" ]; then
  cd "${SERVER_ROOT}" || exit 1
  rm -rf "${SERVER_ROOT:?}"/*
  rm -rf "${SERVER_ROOT:?}"/.local
  wget -q http://terraria.org/server/terraria-server-"${SERVER_VERSION}".zip -O /tmp/"${SERVER_ZIP}"
  bsdtar --strip-components=2 -xvf /tmp/"${SERVER_ZIP}" "${SERVER_VERSION}"/Linux/*
  rm /tmp/"${SERVER_ZIP}"
  cd "${SERVER_ROOT}" || exit 1
  chmod a+rw ./*
  chmod a+x TerrariaServer*
  touch "${VERSIONCHECK}"
  chown -R terraria:terraria "${SERVER_ROOT}"
fi
exec gosu terraria /launch.sh "$@"
