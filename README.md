# docker-mongodb-rs

## What

* Dockerfile creates a docker image with ubuntu 20.04, nodejs 16, [mongodb 5.0.9][mongodb-community-ubuntu] and [run-rs][run-rs]

* run-rs will run a mongodb server with 3 node replica set.

## Why

This image can be used for running tests against a mongodb server with replica sets in CI.

## How

```shell
# build
docker build -t mongodb-rs .

# run
mkdir -p mongodb-data
docker stop mongodb-rs && docker rm -vf mongodb-rs
docker run -d --name mongodb-rs -v data:/app/mongodb-data -p 127.0.0.1:27017:27017 -p 127.0.0.1:27018:27018 -p 127.0.0.1:27019:27019 mongodb-rs
docker logs -f mongodb-rs
```

## verify

```shell
curl localhost:27017
```


## Why the version choice:

1. [why nodejs 16](https://github.com/vkarpov15/run-rs/issues/62#issuecomment-1159359964)
2. [why ubuntu 20.04](https://www.mongodb.com/docs/manual/administration/production-notes/#platform-support-matrix)

[run-rs]:https://github.com/vkarpov15/run-rs
[mongodb-community-ubuntu]:https://www.mongodb.com/docs/manual/tutorial/install-mongodb-on-ubuntu/