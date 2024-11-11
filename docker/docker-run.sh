#!/bin/sh

mkdir -p qmdata

docker run \
    -d \
    -p 4222:22 \
    -p 4242:4242 \
    -p 4243:4243 \
    -v $(pwd)/qmdata:/qmdata \
    openqm:latest
