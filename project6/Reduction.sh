#!/bin/bash

echo "MultArrayReduction"
echo "Num_elements,   Local_Size,    Performance"
for t in 1 2 4 8
do
        #echo Number of elements = $t
        #BLOCKSIZE:
        for s in 8 16 32 64 128 256 512 
        do
            #echo BLOCKSIZE = $s
            g++ -DNMB=$t -DLOCAL_SIZE=$s -o Reduction Reduction.cpp /usr/local/apps/cuda/10.1/lib64/libOpenCL.so.1.1 -lm -fopenmp
            ./Reduction
        done
done
rm Reduction