#!/usr/bin/env bash

incus list -c name --format csv,noheader | awk -F, '/^example-/ { print $1 }' | xargs incus delete --force
