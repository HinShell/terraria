#!/bin/bash
for mod in /mods/*.tmod
do
  lmod="${lmod}\"$(basename "${mod%.*}")\","
done

lmod="[${lmod%?}]"
echo "${lmod}" > /mods/enabled.json
chown -R terraria:terraria /mods/enabled.json

exec gosu terraria /launch.sh "$@"