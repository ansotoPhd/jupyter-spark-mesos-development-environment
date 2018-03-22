#!/usr/bin/env bash

actual_path=$(readlink -f "${BASH_SOURCE[0]}")
script_dir=$(dirname "$actual_path")

cd $script_dir
docker-compose -f hdfs-cluster.yml up