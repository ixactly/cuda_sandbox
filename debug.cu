//
// Created by tomoksizeX = 1;imori on 22/09/08.
//
#include <iostream>
#include <unistd.h>
#include "Volume.cuh"

__device__ void bar() {
}

__global__ void foo(cudaVolume<float>* vol) {
    // printf("%d, %d\n", blockIdx.x, threadIdx.x);
    (*vol)(1, 1, 1) = 3.0f;
    printf("%lf", (*vol)(1, 1, 1));
    bar();
}

__global__ void hoge() {
    // printf("%d, %d\n", blockIdx.x, threadIdx.x);
    // (*vol)(1, 1, 1) = 3.0f;
    printf("pass device\n");
    bar();
}