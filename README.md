[![](https://quay.io/repository/humu/rq-scheduler/status)](https://quay.io/repository/humu/rq-scheduler)

# rq-scheduler
Docker image of [rq-scheduler](https://github.com/ui/rq-scheduler).

# Usage

```
docker run -d quay.io/humu/rq-scheduler \
  -e RQ_REDIS_URL=http://redis.example.com:6379 \
  -e INTERVAL=30
  /sbin/my_init
```

The following environment variables are supported. See [rq-scheduler](https://github.com/ui/rq-scheduler) doc and code for details:

* `INTERVAL` - how often scheduler checks for jobs in float seconds, default: 60
* `RQ_REDIS_HOST` - redis host (only if `RQ_REDIS_URL` not set)
* `RQ_REDIS_PORT` - redis port (only if `RQ_REDIS_URL` not set)
* `RQ_REDIS_DB` - redis database number
* `RQ_REDIS_PASSWORD` - redis password
* `RQ_REDIS_URL` - full URL of redis (in lieu of `REDIS_HOST` and `REDIS_PORT`)
* `OPTIONS` - other options passed to rq-scheduler (e.g., set to --verbose for debugging)

## LICENSE
[![MIT License](http://img.shields.io/badge/license-MIT-blue.svg?style=flat)](LICENSE)
