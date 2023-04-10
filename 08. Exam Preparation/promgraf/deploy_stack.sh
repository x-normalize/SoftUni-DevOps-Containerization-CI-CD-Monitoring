#!/bin/bash

DIR="/home/vagrant/prom"
[ -d "$DIR" ] || echo "Shared dir '$DIR' not found"

SCRIPT_PATH="$DIR/deploy.sh"
[ -f "$SCRIPT_PATH" ] && echo "::: Deploying :::" && source $SCRIPT_PATH || echo "File '$SCRIPT_PATH' not found. Current dir: '${PWD}'"
