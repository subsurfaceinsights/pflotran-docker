#!/bin/bash
set -e
if [ -z "$1" ]
then
  echo "You must specify PETSC version (git ref) to build"
  exit 1
fi
PETSC_VERSION=$1
git clone https://gitlab.com/petsc/petsc 
cd petsc
git checkout $PETSC_VERSION
./configure --CFLAGS='-O3' \
            --CXXFLAGS='-O3' \
            --FFLAGS='-O3' \
            --with-debugging=no \
            --download-mpich=yes \
            --download-hdf5=yes \
            --download-fblaslapack=yes \
            --download-metis=yes \
            --download-parmetis=yes 
export PETSC_DIR=`realpath ./`
export PETSC_ARCH=arch-linux2-c-opt
cd $PETSC_DIR
make all -j$(nproc)
cd ../
