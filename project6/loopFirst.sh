#!/bin/bash

echo "MultArray:"
echo "Num_elements,   Local_Size,    Performance"

# number of threads NMB
for t in 1 2 4 8
do
    # number of subdivisions local size:
    for s in 8 16 32 64 128 256 512 
    do
        g++ -DNMB=$t -DLOCAL_SIZE=$s -o first first.cpp /usr/local/apps/cuda/10.1/lib64/libOpenCL.so.1.1 -lm -fopenmp
        ./first
    done
done
rm first
