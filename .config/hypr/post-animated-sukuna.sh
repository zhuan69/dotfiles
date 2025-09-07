#!/bin/bash

mpv --fullscreen --no-border --really-quiet --loop=no --no-osc --no-input-default-bindings ~/Downloads/sukuna_de.mp4 &
pid=$!
sleep 3.7s # Wait for animation duration (adjust)
kill $pid
