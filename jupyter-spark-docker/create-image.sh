#!/usr/bin/env bash

actual_path=$(readlink -f "${BASH_SOURCE[0]}")
script_dir=$(dirname "$actual_path")

docker build -t jupyter-spark-dev-env:0.1.0 .