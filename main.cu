#include <iostream>
#include "Volume.cuh"
#include <cuda.h>
#include <cuda_runtime.h>
#include "debug.cuh"
#include <unistd.h>

int main() {
    // a

    {// auto vol = new CudaVolume<float> * [3];
        /*
        cuda_ptr<cuda_ptr<CudaVolume<float>>> vol(new cuda_ptr<CudaVolume<float>>[2]);
        // std::cout << sizeof(*vol[0]) << std::endl;

        for (int i = 0; i < 3; i++) {
            // vol[i] = new CudaVolume<float>(10, 10, 10);
            // cudaMallocManaged(reinterpret_cast<void **>(&vol[i]), sizeof(CudaVolume<float>));
            vol[i] = cuda_ptr<CudaVolume<float>>(new CudaVolume<float>(100, 100, 100));
            // cudaMallocManaged(reinterpret_cast<void**>(&vol[i]), sizeof(CudaVolume<float>));
            vol[i]->init(300, 300, 300);
        }

        vol[1]->printDebug();
        // std::cout << (*vol[1])(1,1,1) << std::endl;
        /*
        vol[1]->forEach([](float val) -> float { return 1.0; });
        std::cout << (*vol[1])(1, 1, 1) << std::endl;

        dim3 block(5, 1, 1);
        dim3 grid(5, 1, 1);

        foo<<<1, 1>>>(vol[1].get());
        hoge<<<1, 1>>>();
        cudaDeviceSynchronize();

        std::cout << (*vol[1])(1,1,1) << std::endl;
         */
    }
    {
        cuda_ptr<CudaVolume<float>> *single(new CudaVolume<float>[2]);
        // CudaVolume<float> aa(10, 10, 10);
    }
    sleep(2);


    return 0;
}
