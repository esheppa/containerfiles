#!/bin/sh
podman images --format json | jq .[].ID | cut -d '"' -f 2 | xargs podman rmi -f $_
