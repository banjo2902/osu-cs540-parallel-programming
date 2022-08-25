#!/bin/bash
#SBATCH  --constraint=v100

file=(\"Mult.cl\" \"MultAdd.cl\")
NMB=(1 5 10 50 100 500 1000 1500 2000)
local=(8 16 32 64 128 256 512)

if [ -f "./Mult_and_Add.csv" ]; then
    rm Mult_and_Add.csv
fi
for f in ${file[@]};
do
    echo "$f,Global Dataset Size,Local Work Size,Work Goups,Performance" |& tee -a Mult_and_Add.csv
    for n in ${NMB[@]};
    do
        for l in ${local[@]};
        do
            g++ -o ArrayMult ArrayMult.cpp /usr/local/apps/cuda/10.1/lib64/libOpenCL.so.1.1 -DFILE_NAME=$f -DNMB=$n -DLOCAL_SIZE=$l -lm -fopenmp
            ./ArrayMult |& tee -a Mult_and_Add.csv
        done
    done
done
