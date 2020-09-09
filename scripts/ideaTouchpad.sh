#!/bin/bash
#inverse scrolling

MOUSEID=$(xinput list |grep Touchpad|cut -c 55-56| head -1)
echo $MOUSEID

DEVICE=$(xinput list-props $MOUSEID |grep 'Tapping Enabled (' | cut -c 28-30)
echo $DEVICE

# EXAMPLE: Evdev Scrolling Distance (378):	1, 1, 1

echo `xinput set-prop $MOUSEID $DEVICE 1`
#reversing 1 to -1
