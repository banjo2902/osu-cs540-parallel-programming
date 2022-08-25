#!/bin/bash

# number of threads NMB
for t in 1024 512*1024 1024*1024 2*1024*1024 4*1024*1024 8*1024*1024
do
    # number of subdivisions local size:
    for s in 8 16 32 64 128 256 512 
    do
        g++ -DNUM_ELEMENTS=$t -DLOCAL_SIZE=$s -o first first.cpp /usr/local/apps/cuda/10.1/lib64/libOpenCL.so.1.1 -lm -fopenmp
        ./first
    done
done
rm first
