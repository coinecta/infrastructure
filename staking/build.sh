#!/bin/bash

docker build -f Coinecta.Sync.dockerfile -t coinecta-sync .
docker build -f Coinecta.API.dockerfile -t coinecta-api .
docker build -f Coinecta.Catcher.dockerfile -t coinecta-catcher .