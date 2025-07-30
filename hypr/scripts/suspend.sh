#!/bin/bash

swayidle -w \
timeout 600 'hyprctl dispatch dpms off' \
resume 'hyprctl dispatch dpms on' \
timeout 900 'sudo loginctl suspend'
