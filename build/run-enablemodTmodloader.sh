#!/bin/bash
if [ "$(ls -A /mods/*.tmod 2>/dev/null)" ];then
  for mod in /mods/*.tmod
  do
    lmod="${lmod}\"$(basename "${mod%.*}")\","
  done

  lmod="[${lmod%?}]"
  echo "${lmod}" > /mods/enabled.json
  chown -R terraria:terraria /mods/enabled.json
else
  rm -f /mods/enabled.json
fi
exec gosu terraria /launch.sh "$@"
