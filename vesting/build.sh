#!/bin/bash

docker build -f Coinecta.Sync.dockerfile -t coinecta-vesting-sync .
docker build -f Coinecta.API.dockerfile -t coinecta-vesting-api .
docker build -f Coinecta.MPF.dockerfile -t coinecta-mpf-api .
# docker build -f Coinecta.Catcher.dockerfile -t coinecta-catcher .