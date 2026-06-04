#!/usr/bin/env bash

set -eu

: ${IMAGE:=ghcr.io/asssaf/llmster}

docker run --rm -it \
	--net=host \
	-v "${PWD}/models:/root/.lmstudio/models" \
	$IMAGE
