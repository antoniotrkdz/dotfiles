#!/bin/bash

pkill -u "$USER" pipewire-pulse >/dev/null 2>&1
pkill -u "$USER" wireplumber >/dev/null 2>&1
pkill -u "$USER" pipewire >/dev/null 2>&1

pipewire &

until pgrep -f pipewire >/dev/null 2>&1; do
   sleep 1
done

wireplumber &

pipewire-pulse &
