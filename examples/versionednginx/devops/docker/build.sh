#!/usr/bin/env bash

docker build -f Dockerfile-1.0 -t agarwalconsulting/versioned-nginx:v1 .
docker push agarwalconsulting/versioned-nginx:v1

docker build -f Dockerfile-2.0 -t agarwalconsulting/versioned-nginx:v2 .
docker push agarwalconsulting/versioned-nginx:v2

docker build -f Dockerfile-liveness -t agarwalconsulting/versioned-nginx:liveness .
docker push agarwalconsulting/versioned-nginx:liveness
