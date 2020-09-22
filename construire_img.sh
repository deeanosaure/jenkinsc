#!/bin/bash


# Use the Git Commit and set the Docker Image
DOCKER_IMG_BASENAME="demo-app"
DOCKER_IMG_FULLNAME="demo-app:1515154848481515"
# Build the Docker image
docker build -t "${DOCKER_IMG_FULLNAME}" ./
docker tag "${DOCKER_IMG_FULLNAME}" "${DOCKER_IMG_BASENAME}:latest"
# Simple Smoke test: Start and stop the Docker image
CID="$(docker run -d -P ${DOCKER_IMG_FULLNAME})"
docker kill "${CID}"
docker rm -v "${CID}"
