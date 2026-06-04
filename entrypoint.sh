#!/usr/bin/env bash

set -eu

lms daemon up
lms server start --port 1234

echo "Going to sleep..."
sleep infinity
echo "Exiting..."
