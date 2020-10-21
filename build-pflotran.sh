#!/bin/bash
set -e
export PETSC_DIR=`realpath petsc`
export PETSC_ARCH=arch-linux2-c-opt
if [ -z "$1" ] 
then
  print "You must specify the PFLOTRAN version (get ref) as the first argument"
  exit 1
fi
PFLOTRAN_REF=$1
git clone https://bitbucket.org/pflotran/pflotran
cd pflotran
git checkout $PFLOTRAN_REF
for patch in ../pflotran-patches/*
do
  git apply $patch 
done 
cd src/pflotran
make pflotran -j$(nproc)
