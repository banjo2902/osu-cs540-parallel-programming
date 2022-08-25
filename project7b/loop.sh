#!/bin/bash

#module load slurm  (Use this when in DGX server)
module load openmpi/3.1

#Number of processors
for s in 1 2 4 8 16
    do
        mpic++ main.cpp -o main -lm
        mpiexec -np $s main
    done

rm main