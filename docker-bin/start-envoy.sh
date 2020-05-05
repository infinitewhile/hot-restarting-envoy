#!/bin/bash
envoy -c /etc/envoy/envoy.yaml --restart-epoch $RESTART_EPOCH --drain-time-s 0 --parent-shutdown-time-s 0