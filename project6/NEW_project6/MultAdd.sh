#!/bin/bash


for t in 1024 512*1024 1024*1024 2*1024*1024 4*1024*1024 8*1024*1024
do
        #echo Number of elements = $t
        #BLOCKSIZE:
        for s in 8 16 32 64 128 256 512 
        do
            #echo BLOCKSIZE = $s
            g++ -DNUM_ELEMENTS=$t -DLOCAL_SIZE=$s -o MultAdd MultAdd.cpp /usr/local/apps/cuda/10.1/lib64/libOpenCL.so.1.1 -lm -fopenmp
            ./MultAdd
        done
done
rm MultAdd 