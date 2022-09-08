//
// Created by tomokimori on 22/09/08.
//

#ifndef CUDA_SANDBOX_DEBUG_CUH
#define CUDA_SANDBOX_DEBUG_CUH

#include <cuda.h>
#include <cuda_runtime.h>

__device__ void bar();

__global__ void foo(CudaVolume<float> *vol);

template<typename T>
class cuda_ptr {
private :
    T *ptr = nullptr;
public :
    cuda_ptr() = default;

    explicit cuda_ptr(T *ptr)
            : ptr(ptr) {}

    ~cuda_ptr() { cudaFree(ptr); }

    cuda_ptr(const cuda_ptr &) = delete;

    cuda_ptr &operator=(const cuda_ptr &) = delete;

    cuda_ptr(cuda_ptr &&r) noexcept
            : ptr(r.ptr) { r.ptr = nullptr; }

    cuda_ptr &operator=(cuda_ptr &&r) noexcept {
        delete ptr;
        ptr = r.ptr;
        r.ptr = nullptr;
    }

    T &operator*() noexcept { return *ptr; }

    T *operator->() noexcept { return ptr; }

    T &operator[](std::size_t i) const { return ptr[i]; }

    T *get() noexcept { return ptr; }
};

#endif //CUDA_SANDBOX_DEBUG_CUH
