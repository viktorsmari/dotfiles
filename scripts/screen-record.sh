#!/usr/bin/env bash

if pgrep -x "wf-recorder" > /dev/null; then
    notify-send "Screen Recorder" "Stopping current recording..." -t 2000
    pkill wf-recorder
    exit 1
else
    notify-send "Screen Recorder" "Choose a region to record..." -t 2000
    wf-recorder -g "$(slurp)" -f ~/Videos/$(date +%Y-%m-%d-%H-%M-%S).mp4
    exit 0
fi
