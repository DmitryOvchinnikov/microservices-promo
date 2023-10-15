#!/bin/bash

USER_NAME="Dmitry Ovchinnikov"
EMAIL="dmitry.v.ovchinnikov@gmail.com"

git config user.name "$USER_NAME"
git config user.email "$EMAIL"
git fetch --all && git checkout main

protoc -I order/ order/order.proto --go_out=./pb;
protoc -I payment/ payment/payment.proto --go_out=./pb;
protoc -I shipping/ shipping/shipping.proto --go_out=./pb;

cd ./pb
go mod init github.com/dmitryovchinnikov/microservices-proto/pb
go mod tidy
