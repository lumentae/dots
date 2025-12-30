#!/bin/bash
find /container -maxdepth 1 -type l -exec rm {} \;

declare -a NAMES
declare -a PIDS

while read -r name pid; do
    NAMES+=("$name")
    PIDS+=("$pid")
done < <(lxc-ls -f -Fname,pid | tail -n +2)

for i in "${!NAMES[@]}"; do
    echo "Container Name: ${NAMES[i]}, PID: ${PIDS[i]}"
    ln -s "/proc/${PIDS[i]}/root" "/container/${NAMES[i]}"
done
