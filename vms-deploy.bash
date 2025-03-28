#!/usr/bin/env bash

declare -A vms
vms=(
    [debian]='debian/12/cloud'
    [alpine]='alpine/3.21/cloud'
)

for name in "${!vms[@]}"; do
    image="${vms[$name]}"
    incus launch "images:$image" "example-$name" \
        --vm \
        --config limits.cpu=1 \
        --config limits.memory=4GiB \
        --config security.secureboot=false
done
