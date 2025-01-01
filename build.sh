#!/bin/bash
docker buildx build --platform linux/amd64 -t tylerstraub/node-base-image:latest .
docker push tylerstraub/node-base-image:latest