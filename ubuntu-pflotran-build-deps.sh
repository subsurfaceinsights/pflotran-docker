#!/bin/bash
set -e
export DEBIAN_FRONTEND=noninteractive
apt-get update -y 
apt-get install -y \
    git \
    gfortran \
    cmake \
    gcc \
    python \
    g++ 

