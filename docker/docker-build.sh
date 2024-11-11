#!/bin/sh

docker buildx build --platform linux/386 -f Dockerfile -t openqm:latest .. 
