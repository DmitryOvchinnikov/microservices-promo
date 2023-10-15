#!/bin/bash

USER_NAME="Dmitry Ovchinnikov"
EMAIL="dmitry.v.ovchinnikov@gmail.com"
RELEASE_VERSION="0.0.1"

git config user.name "$USER_NAME"
git config user.email "$EMAIL"
git fetch --all && git checkout main

protoc -I order/ order/order.proto --go_out=./pb --go-grpc_out=./pb
protoc -I payment/ payment/payment.proto --go_out=./pb --go-grpc_out=./pb
protoc -I shipping/ shipping/shipping.proto --go_out=./pb --go-grpc_out=./pb

cd ./pb
go mod init github.com/dmitryovchinnikov/microservices-proto/pb
go mod tidy

cd ..

git add . && git commit -am "proto update" || true
git push origin HEAD:main
#git tag -fa pb/${SERVICE_NAME}/${RELEASE_VERSION} -m "pb/${SERVICE_NAME}/${RELEASE_VERSION}"
#git push origin refs/tags/pb/${SERVICE_NAME}/${RELEASE_VERSION}

