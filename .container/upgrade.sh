#!/bin/bash
declare -a NAMES

while read -r name; do
    NAMES+=("$name")
done < <(lxc-ls -f -Fname | tail -n +2)

for i in "${!NAMES[@]}"; do
    echo "Upgrading ${NAMES[i]}..."
    pct exec ${NAMES[i]} -- sudo apt update
    pct exec ${NAMES[i]} -- sudo apt upgrade -y
done
