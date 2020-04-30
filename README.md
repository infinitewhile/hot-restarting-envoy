# Hot restarting Envoy container

This setup is for the purpose of experimenting quickly with Envoy configuration locally. It is not meant for production use.

The setup will run Envoy in Docker whilst watching a local proxy config file for change. Given a file change, Envoy is asked to reload. If Envoy crashes at any point and a file change occurs again, it will attempt to bring the container back online.

This setup has been tested and ran on Mac 10.14 only. The container build is currently pinned to version 1.14.1 of Envoy. Some tweaking may be required.

Documentation for Envoy v1.14.1 can be found at [https://www.envoyproxy.io/docs/envoy/v1.14.1](https://www.envoyproxy.io/docs/envoy/v1.14.1).

## Prerequists

- [Docker](https://docs.docker.com/get-docker/)
- [fswatch](https://github.com/emcrisostomo/fswatch) - `brew install fswatch`

## Setup

```bash
docker build -t hot-restarting-envoy:v1.14.1 .
./start.sh
```

## Updating config

After running the `./start.sh` command without any errors, the `proxy_config.v2.yaml` file will be watched for any changes. Making changes locally will result in Envoy reloading and the change(s) available almost straight away.