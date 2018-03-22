#!/usr/bin/env bash

dir=$(dirname "$0")
docker-compose -f $dir/mesos-cluster.yml up
