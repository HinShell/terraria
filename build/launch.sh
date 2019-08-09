#!/bin/bash
/data/"${1}" -x64 -config /config/server.conf | tee /logs/terraria-"$(date +"%m_%d_%Y")".log
