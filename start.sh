#!/usr/bin/env bash

CONTAINER_NAME='test_envoy'

# On script exit, stop and remove the container.
function cleanup {
  echo "Stopping $CONTAINER_NAME container"
  docker kill $CONTAINER_NAME
  echo "Removing $CONTAINER_NAME container"
  docker rm $CONTAINER_NAME
}

trap cleanup EXIT

# Run Envoy in the background
echo "Running container $CONTAINER_NAME..."

docker run \
	-d \
	--name $CONTAINER_NAME \
	-p 10000:10000 \
	-p 9901:9901 \
	-v $(pwd)/proxy_config.v2.yaml:/etc/envoy/envoy.yaml \
	hot-restarting-envoy:v1.14.1

echo "\nEnvoy container is running. Open http://localhost:10000"

# Watch for config file changes and reload
echo "\nStarting to watch proxy_config.v2.yaml for changes..."
fswatch -0 proxy_config.v2.yaml | xargs -0 -I {} ./reload-config.sh