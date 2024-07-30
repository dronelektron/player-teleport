#!/bin/bash

PLUGIN_NAME="player-teleport"

cd scripting
spcomp $PLUGIN_NAME.sp -i include -o ../plugins/$PLUGIN_NAME.smx
