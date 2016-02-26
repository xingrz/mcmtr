#!/bin/bash

function move() {
  if ([ -f "/server/$1" ] || [ -d "/server/$1" ]) && [ ! -L "/server/$1" ]; then
    mv -v "/server/$1" "/data/$1"
    ln -v -s "/data/$1" "/server/$1"
  fi
}

move "server.properties"

move "config"
move "crash-reports"
move "logs"
move "mods"
move "world"

move "banned-ips.json"
move "banned-players.json"
move "ops.json"
move "whitelist.json"

java -jar /server/forge-1.7.10-10.13.4.1448-1.7.10-universal.jar nogui
