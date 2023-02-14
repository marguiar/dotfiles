#!/bin/bash

for i in /sys/class/hwmon/hwmon*/temp*_input; do 
    if [ "$(<$(dirname $i)/name): $(cat ${i%_*}_label 2>/dev/null || echo $(basename ${i%_*}))" = "coretemp: Package id 0" ]; then
        # export HWMON_PATH="$(readlink -f $i)"
        set HWMON_PATH="$(readlink -f $i)"
    fi
done