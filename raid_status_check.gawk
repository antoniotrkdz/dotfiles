#!/bin/gawk -f
# This script checks the status of RAID arrays from /proc/mdstat

/_/ { state = "[Warning!]"; exit }
/blocks/ { state = $NF }

END { print state }
