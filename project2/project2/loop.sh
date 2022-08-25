#!/bin/bash

clear
for t in 1 2 4 8 12 16 20 24 
do
  for n in 32 64 128 256 512 1024 2048 3072 
  do
    g++ -O3 proj02.cpp -DNUMT=$t -DNUMNODES=$n -o proj02 -lm -fopenmp
    ./proj2
  done
done