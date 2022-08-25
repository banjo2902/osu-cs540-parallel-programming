#!/bin/bash
#SBATCH  --constraint=v100

NMB=(1 5 10 50 100 500 1000 1500 2000)
local=(32 64 128 256)

if [ -f "./Mult_reduction.csv" ]; then
    rm Mult_reduction.csv
fi
echo "NMB,Global Dataset Size,Local Work Size,Work Goups,Performance" |& tee -a Mult_reduction.csv
for n in ${NMB[@]};
do
    for l in ${local[@]};
    do
        g++ -o ArrayMultReduction ArrayMultReduction.cpp /usr/local/apps/cuda/10.1/lib64/libOpenCL.so.1.1 -DNMB=$n -DLOCAL_SIZE=$l -lm -fopenmp
        ./ArrayMultReduction |& tee -a Mult_reduction.csv
    done
done
