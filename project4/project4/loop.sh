#!/bin/bash

for t in 1000000 2000000 3000000 4000000 5000000 
do
  g++ proj04.cpp  -DARRAYSIZE=$t  -o proj04  -lm  -fopenmp
  ./proj04
done

