

# DS4 
~~~
CUDA_SCHEDULE_YIELD=1 taskset -c 0-15 ./ds4 -m models/DeepSeek-V4-Flash-IQ2XXS-w2Q2K-AProjQ8-SExpQ8-OutQ8-chat-v2-imatrix-0731.gguf --threads 8 --ctx 16384

./ds4 -m models/DeepSeek-V4-Flash-IQ2XXS-w2Q2K-AProjQ8-SExpQ8-OutQ8-chat-v2-imatrix-0731.gguf --threads 8 --ctx 4096


lscpu
Architecture:                x86_64
  CPU op-mode(s):            32-bit, 64-bit
  Address sizes:             39 bits physical, 48 bits virtual
  Byte Order:                Little Endian
CPU(s):                      20
  On-line CPU(s) list:       0-19
Vendor ID:                   GenuineIntel
  Model name:                12th Gen Intel(R) Core(TM) i7-12700KF

nvidia-smi dmon -s u -i 0
# gpu     sm    mem    enc    dec    jpg    ofa
# Idx      %      %      %      %      %      %
    0    100      0      0      0      0      0


make clean
make cuda-generic CUDA_HOME=/usr/local/cuda-12.4 CUDA_ARCH="-arch=sm_86" NVCCFLAGS="-arch=sm_86 -std=c++14 -DCUDA_SYNC_YIELD"

make cuda-generic CUDA_HOME=/usr CUDA_ARCH="-arch=sm_86" NVCCFLAGS="-arch=sm_86 -std=c++14"


compute-sanitizer --tool memcheck ./ds4 -m models/DeepSeek-V4-Flash-IQ2XXS-w2Q2K-AProjQ8-SExpQ8-OutQ8-chat-v2-imatrix-0731.gguf --ctx 4096


export CUDA_VISIBLE_DEVICES=0
export CUDA_LAUNCH_BLOCKING=1 
taskset -c 0-15 ./ds4 -m gguf/DeepSeek-V4-Flash-IQ2XXS-w2Q2K-AProjQ8-SExpQ8-OutQ8-chat-v2-imatrix.gguf --threads 8 --ctx 16384 --backend cuda

gdb --args ./ds4 --cuda -p "Hello"

-- For larger models (requiring CPU + GPU hybrid execution):
./ds4-cli -m /path/to/large-model.gguf --cuda --gpu-vram 22 --ctx-max 8192
~~~


