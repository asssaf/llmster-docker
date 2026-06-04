#!/usr/bin/env bash

set -eu

: ${IMAGE:=asssaf/llmster}

docker run --rm -it \
	--net=host \
	-v "${PWD}/models:/root/.lmstudio/models" \
	$IMAGE
