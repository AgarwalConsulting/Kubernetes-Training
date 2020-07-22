SHELL := /bin/bash

build-docker-1.0:
	docker build -f Dockerfile-1.0 -t agarwalconsulting/versioned-nginx:v1 .

push-docker-1.0:
	docker push agarwalconsulting/versioned-nginx:v1

build-docker-2.0:
	docker build -f Dockerfile-2.0 -t agarwalconsulting/versioned-nginx:v2 .

push-docker-2.0:
	docker push agarwalconsulting/versioned-nginx:v2

build-docker-liveness:
	docker build -f Dockerfile-liveness -t agarwalconsulting/versioned-nginx:liveness .

push-docker-liveness:
	docker push agarwalconsulting/versioned-nginx:liveness

run-docker-liveness:
	docker run -d --name nginx-liveness -p 8000:80 agarwalconsulting/versioned-nginx:liveness
