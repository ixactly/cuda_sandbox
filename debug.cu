//
// Created by tomokimori on 22/09/08.
//
#include <iostream>
#include <unistd.h>
#include "Volume.cuh"

__device__ void bar() {
}

__global__ void foo(CudaVolume<float>* vol) {
    // printf("%d, %d\n", blockIdx.x, threadIdx.x);
    (*vol)(1, 1, 1) = 3.0f;
    // printf("%lf", vol(3, 4, 5));
    bar();
}