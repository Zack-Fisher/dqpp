#!/bin/bash

## we want to literally bake the env vars into the service images themselves.
# launch the milvus server
# pass ports.env to the docker-compose file
sudo docker compose --env-file ./ports.env -f ./backends/go_milvus_backend/docker-compose.yml up -d
sudo docker compose --env-file ./ports.env up -d "$@"
