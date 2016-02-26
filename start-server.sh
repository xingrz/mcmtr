#!/bin/bash

function link() {
  if [ -f "/server/$1" || -d "/server/$1" ]; then
    mv "/server/$1" "/data/$1"
    ln -s "/data/$1" "/server/$1"
  fi
}

function create() {
  if [ ! -f "/server/$1" ]; then
    echo "[]" > "/data/$1"
    ln -s "/data/$1" "/server/$1"
  fi
}

link "server.properties"
link "config"
link "crash-reports"
link "logs"
link "mods"
link "world"

create "banned-ips.json"
create "banned-players.json"
create "ops.json"
create "whitelist.json"

java -jar /server/forge-1.7.10-10.13.4.1448-1.7.10-universal.jar nogui
