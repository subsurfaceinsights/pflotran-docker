#!/bin/bash
set -e
export PETSC_DIR=`realpath petsc`
export PETSC_ARCH=arch-linux-c-opt
if [ -z "$1" ]
then
  echo "You must specify the PFLOTRAN version (get ref) as the first argument"
  exit 1
fi
PFLOTRAN_REF=$1
if [ ! -d pflotran ]
then
  git clone https://bitbucket.org/pflotran/pflotran
  cd pflotran
  git checkout $PFLOTRAN_REF
  for patch in ../pflotran-patches/*
  do
    git apply $patch
  done
else
  echo "Using existing PFLOTRAN dir"
  cd pflotran
fi
cd src/pflotran
make pflotran -j$(nproc)
