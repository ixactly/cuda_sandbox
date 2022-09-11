//
// Created by tomokimori on 22/09/08.
//

#ifndef CUDA_SANDBOX_DEBUG_CUH
#define CUDA_SANDBOX_DEBUG_CUH

#include <cuda.h>
#include <cuda_runtime.h>
#include <unistd.h>
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
        if (ptr != nullptr)
            (*ptr).~T();
        else
            std::cout << "denied calling destructor\n";

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
    T* dst;
    T* src = new T(std::forward<Args>(args)...); // cannot delete this memory

    cudaMallocManaged(reinterpret_cast<void **>(&dst), sizeof(T));
    std::memcpy(dst, src, sizeof(T));

    std::cout << "in make_cuda, ptr: " << dst << std::endl;
    free(src);
    std::cout << "alloc src, free, ptr: " << src << std::endl;
    std::cout << "make_cuda out" << std::endl;

    return cuda_ptr<T>(dst);
}

#endif //CUDA_SANDBOX_DEBUG_CUH
