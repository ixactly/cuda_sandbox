//
// Created by tomokimori on 22/09/08.
//

#ifndef CUDA_SANDBOX_DEBUG_CUH
#define CUDA_SANDBOX_DEBUG_CUH

#include <cuda.h>
#include <cuda_runtime.h>

__device__ void bar();

__global__ void foo(cudaVolume<float> *vol);

__global__ void hoge();

template<typename T>
class cuda_ptr {
private :
    T *ptr = nullptr;
public :
    cuda_ptr() = default;

    explicit cuda_ptr(T *r_ptr)
            : ptr(r_ptr) {
        std::cout << "cuda_ptr " << typeid(T).name() << "* cuda mem allocated, rvalue ptr: " << r_ptr << std::endl;
        std::cout << "cuda_ptr " << typeid(T).name() << "* cuda mem allocated, lvalue ptr: " << ptr << std::endl;

        // !!! cudaMalloc -> change ptr adress
    }

    ~cuda_ptr() {
        std::cout << "cuda_ptr " << typeid(T).name() << "* calling destructor of T, ptr: " << ptr << std::endl;
        (*ptr).~T();

        std::cout << "cuda_ptr " << typeid(T).name() << "* cudaFree of, ptr: " << ptr << std::endl;
        cudaFree(ptr);
    }

    cuda_ptr(const cuda_ptr &) = delete;

    cuda_ptr &operator=(const cuda_ptr &) = delete;

    cuda_ptr(cuda_ptr &&r) noexcept
            : ptr(r.ptr) {
        std::cout << "malloc by move constructor, ptr: " << r.ptr << std::endl;
        r.ptr = nullptr;
    }

    cuda_ptr &operator=(cuda_ptr &&r) noexcept {
        std::cout << "malloc by move assignment, rvalue ptr: " << r.ptr << std::endl;
        std::cout << "malloc by move assignment, lvalue ptr: " << ptr << std::endl;
        ptr = r.ptr;
        std::cout << "move assigned, ptr: " << ptr << std::endl;
        r.ptr = nullptr;

        return *this;
    }

    T &operator*() noexcept { return *ptr; }

    T *operator->() noexcept { return ptr; }

    T &operator[](std::size_t i) const { return ptr[i]; }

    T *get() noexcept { return ptr; }
};

template <class T, class... Args>
cuda_ptr<T> make_cudaptr(Args&&... args) {
    std::cout << "in make_cuda" << std::endl;

    T* ptr;
    T tmp(std::forward<Args>(args)...);
    cudaMallocManaged(reinterpret_cast<void **>(&ptr), sizeof(T));
    std::memcpy(ptr, &tmp, sizeof(T));

    std::cout << "make_cuda out" << std::endl;

    return cuda_ptr<T>(ptr);
}

#endif //CUDA_SANDBOX_DEBUG_CUH
