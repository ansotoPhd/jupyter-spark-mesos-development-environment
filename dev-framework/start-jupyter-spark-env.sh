#!/usr/bin/env bash

actual_path=$(readlink -f "${BASH_SOURCE[0]}")
script_dir=$(dirname "$actual_path")

sudo docker run --net=host -ti -v $script_dir/jupyter-workspace:/workspace:rw jupyter-spark-dev-env:0.1.0
