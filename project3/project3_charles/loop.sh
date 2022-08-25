#!/bin/csh

g++ -O3 fd3.cpp -o fd3 -lm -fopenmp
./fd3
