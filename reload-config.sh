#!/usr/bin/env bash

CONTAINER_NAME='test_envoy'

echo -e "\nRestarting..."
# Check if our container is running. We might have broken
# it previously with a bad config setup.
RUNNING=$(docker inspect -f '{{.State.Running}}' $CONTAINER_NAME)

if [ $RUNNING != true ]; then
    echo "Container not running. Force restarting..."
    docker restart $CONTAINER_NAME
fi

# With the container running, ask Envoy to reload.
docker kill --signal=SIGHUP $CONTAINER_NAME

