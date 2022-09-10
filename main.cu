#include <iostream>
#include "Volume.cuh"
#include <cuda.h>
#include <cuda_runtime.h>
#include "debug.cuh"
#include <unistd.h>

int main() {
    // a

    {// auto vol = new cudaVolume<float> * [3];
        /*
        cuda_ptr<cuda_ptr<cudaVolume<float>>> vol(new cuda_ptr<cudaVolume<float>>[2]);
        // std::cout << sizeof(*vol[0]) << std::endl;

        for (int i = 0; i < 3; i++) {
            // vol[i] = new cudaVolume<float>(10, 10, 10);
            // cudaMallocManaged(reinterpret_cast<void **>(&vol[i]), sizeof(cudaVolume<float>));
            vol[i] = cuda_ptr<cudaVolume<float>>(new cudaVolume<float>(100, 100, 100));
            // cudaMallocManaged(reinterpret_cast<void**>(&vol[i]), sizeof(cudaVolume<float>));
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
        /*
        cuda_ptr<float> floating[2];
        for (auto &e : floating) {
            e = cuda_ptr<float>(new float(3.0));
        }
         */
        /*
        cuda_ptr<float> floating = cuda_ptr<float>(new float(4.0f));
        std::cout << *(floating) << std::endl;
         */


        cuda_ptr<float> floating; // nullptr
        auto tmp = new float (5.0f);
        std::cout << "rvalue ptr: " << tmp << std::endl;
        std::cout << "lvalue ptr: " << floating.get() << std::endl;

        floating = cuda_ptr<float>(tmp); // issue

        std::cout << "lvalue after assigned, ptr: " << floating.get() << std::endl;
        // dainyuu to dainyuu constructor de kekka ga tigau
        // cuda_ptr<cudaVolume<float>> single = cuda_ptr<cudaVolume<float>>(new cudaVolume<float>(1000, 1000, 1000));;

        // cuda_ptr<cudaVolume<float>> single;
        // single = cuda_ptr<cudaVolume<float>>(new cudaVolume<float>(1000, 1000, 1000));

        /*
        for (auto &e : single) {
         // e = cuda_ptr<cudaVolume<float>>(new cudaVolume<float>(1000, 1000, 1000));
        }
        */
        cudaDeviceSynchronize();
        sleep(2);
    }
    sleep(5);


    return 0;
}
