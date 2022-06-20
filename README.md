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
docker run -d --name mongodb-rs -v `pwd`/mongodb-data:/app/mongodb-data -p 127.0.0.1:27017:27017 -p 127.0.0.1:27018:27018 -p 127.0.0.1:27019:27019 mongodb-rs
docker logs -f mongodb-rs
```

Note: 

1. To avoid purging of mongodb data append `--keep` flag to the docker run
2. To connect and view the db locally on host machine OR using [MongoDB Compass][mongodb-compass], append `--bind_ip_all` flag to the docker run command

```shell
# stop any existing mongodb-rs containers
docker stop mongodb-rs && docker rm -vf mongodb-rs

# re-run with --keep and --bind_ip_all flags
docker run -d --name mongodb-rs -v `pwd`/mongodb-data:/app/mongodb-data -p 127.0.0.1:27017:27017 -p 127.0.0.1:27018:27018 -p 127.0.0.1:27019:27019 mongodb-rs --keep --bind_ip_all
```

## Verify

```shell
docker exec mongodb-rs bash -c "curl localhost:27017"
```

If running with `--bind_ip_all` then,

```shell
curl localhost:27017
```

## How to connect to MongoDB Compass

Note: this only works if `--bind_ip_all` flag is added

MongoDB Atlas > New Connection > URI: `mongodb://localhost:27017,localhost:27018,localhost:27019/?replicaSet=rs` > Connect

## Why the version choice:

1. [why nodejs 16](https://github.com/vkarpov15/run-rs/issues/62#issuecomment-1159359964) - As of June 19, 2022, current version of [run-rs 0.7.6](https://github.com/vkarpov15/run-rs/releases/tag/0.7.6) only works with node v16 or below.
2. [why ubuntu 20.04](https://www.mongodb.com/docs/manual/administration/production-notes/#platform-support-matrix) - As of June 19, 2022, all of the official nodejs (including v16) docker images use Debain with ARM64. And latest stable version of MongoDB 5.0.9 does not work on Debian with ARM64 but works on Ubuntu 20.04 ARM64.

[run-rs]:https://github.com/vkarpov15/run-rs
[mongodb-community-ubuntu]:https://www.mongodb.com/docs/manual/tutorial/install-mongodb-on-ubuntu
[mongodb-compass]:https://www.mongodb.com/products/compass
