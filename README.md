# pflotran-docker

## Overview

Containerized version of [PFLOTRAN](https://www.pflotran.org/)

## Quick Start

If you have a dedicated directory for a model to hold the input and output
files, first go to that directory in your shell. For example, 
if you have a directory called `model_files` in your home directory, then 
issue:

```
$ cd ~/model_files
```

Suppose you have a model input file in that directory called `exampleinfile.in`

You can invoke PFLOTRAN with:

```
$ docker run -v $(pwd):/data subsurfaceinsights/pflotran -pflotranin ./exampleinfile.in
```

It then run and produce output files in the directory

## Parallel Runs

You can run a model in parallel by setting the `NUM_PROCESSES` environment
variable. Following the previous example:

```
$ docker run -e NUM_PROCESSES=6 -v $(pwd):/data subsurfaceinsights/pflotran -pflotranin ./exampleinfile.in
```

PFLOTRAN will then be invoked with `mpirun -np 6 pflotran` to run with 6
parallel processes

## Advanced Usage Information

The container's working directory is `/data` so mapping any directory to that
data will provide access to model files. 

The container's PFLOTRAN process will run as whatever user owns the `/data` 
directory to maintain ownership consistency. 



