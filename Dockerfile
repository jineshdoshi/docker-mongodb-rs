FROM ubuntu:20.04

# for noninteractive installation of tools
ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=US

# Core dependencies
RUN apt-get update && apt-get install -y curl sudo wget

# Nodejs 16
RUN curl -fsSL https://deb.nodesource.com/setup_16.x | sudo -E bash -
RUN sudo apt-get install -y nodejs

# run-rs https://github.com/vkarpov15/run-rs
RUN npm install run-rs --location=global

# MongoDB 5.0.9
RUN wget -qO - https://www.mongodb.org/static/pgp/server-5.0.asc | sudo apt-key add -
RUN echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu focal/mongodb-org/5.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-5.0.list
RUN sudo apt-get update && apt-get install -y mongodb-org=5.0.9 mongodb-org-database=5.0.9 mongodb-org-server=5.0.9 mongodb-org-shell=5.0.9 mongodb-org-mongos=5.0.9 mongodb-org-tools=5.0.9

EXPOSE 27017 27018 27019

WORKDIR /app

RUN mkdir -p mongodb-data

CMD ["run-rs", "-v", "5.0.9", "--dbpath", "/app/mongodb-data", "--keep", "--mongod"]