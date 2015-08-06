HOST = quay.io
NAME = humu/rq-scheduler
VERSION = 0.0.1

IMAGE = $(HOST)/$(NAME):$(VERSION)

INTERVAL ?= 5
OPTIONS ?= ""

build:
	docker build -t $(IMAGE) .

test: build
	docker run --rm $(IMAGE) /bin/bash -c rq-scheduler

tag:
	docker tag -f $(IMAGE) $(HOST)/$(NAME):latest

release: tag
	docker push $(HOST)/$(NAME)

start-redis:
	@(docker ps --filter=name=redis --filter=status=running | grep -q redis) \
	  || (echo 'starting redis' && docker run -d --name redis redis)

stop-redis:
	@(docker rm -f redis 2>/dev/null && echo stopped) \
	  || echo 'redis not running'

run: start-redis
	docker run -d \
	  --link redis:redis \
      -e RQ_REDIS_URL=http://redis:6379 \
      -e INTERVAL=$(INTERVAL) \
      -e OPTIONS=$(OPTIONS) \
	  --name rq-scheduler \
	  -h rq-scheduler \
	  -p 9181:9181 \
	  $(IMAGE) /sbin/my_init

.PHONY: build test tag release start-redis stop-redis run
