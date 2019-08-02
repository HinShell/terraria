#!/bin/bash

umask 0002

if [[ -v UID && $UID != $(id -u) ]]; then
    usermod -u $UID terraria
fi

if [[ -v GID ]]; then
    groupmod -o -g "$GID" terraria
fi

if [[ $(stat -c "%u" /data) != "$UID" ]];then
    echo "Changing ownership of directories to $UID ..."
    chown -R terraria:terraria /data /world /mods /logs /config
fi

echo "Checking type information."
case "${TYPE^^}" in
  VANILLA)
    exec /run-deployVanilla.sh TerrariaServer
  ;;

  TMODLOADER)
    exec /run-deployTmodloader.sh tModLoaderServer
  ;;

  *)
      echo "Invalid type: '$TYPE'"
      echo "Must be: VANILLA, TMODLOADER"
      exit 1
  ;;
esac

