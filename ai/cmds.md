
sudo nvidia-smi -pm 1
Enabled persistence mode via daemon for GPU 00000000:01:00.0.
All done.
sudo nvidia-smi -pl 260
Power limit for GPU 00000000:01:00.0 was set to 260.00 W from 370.00 W.
All done.


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





llama
git clone https://github.com/ggml-org/llama.cpp
cd llama.cpp
cmake -B build -DGGML_CUDA=ON -DCUDA_ARCHITECTURES="86"
cmake --build build --config Release -j$(nproc) --target llama-cli
cmake --build build --config Release -j$(nproc) --target llama-server

taskset -c 0-15 ./build/bin/llama-cli \
  -m ~/git/ds4/models/DeepSeek-V4-Flash-IQ2XXS-w2Q2K-AProjQ8-SExpQ8-OutQ8-chat-v2-imatrix-0731.gguf \
  -ngl all \
  --n-cpu-moe 60 \
  -t 8 \
  -c 8192 \
  --no-mmap \
  -p "Hello! Can you write a quick Python script to parse a CSV file?"

taskset -c 0-15 ~/git/llama.cpp/build/bin/llama-server \
  -m ~/git/ds4/models/DeepSeek-V4-Flash-IQ2XXS-w2Q2K-AProjQ8-SExpQ8-OutQ8-chat-v2-imatrix-0731.gguf \
  -ngl all \
  --n-cpu-moe 60 \
  -t 8 \
  -c 32768 \
  --no-mmap \
  --port 8080

-m /path/to/your/model.gguf --port 8080

Core i7-12700KF, 1x RTX 3090 24GB, 128GB RAM 

mkdir ~/gguf

hf download Qwen/Qwen2.5-Coder-32B-Instruct-GGUF \
  --include "*q4_k_m*.gguf" \
  --local-dir ~/gguf

hf download Qwen/Qwen2.5-Coder-14B-Instruct-GGUF \
  --include "*q5_k_m*.gguf" \
  --local-dir ~/gguf

hf download unsloth/DeepSeek-R1-Distill-Qwen-32B-GGUF \
  --include "*Q4_K_M*.gguf" \
  --local-dir ~/gguf

# Example for Qwen2.5-Coder-32B-Instruct Q4_K_M on an RTX 3090 (24GB VRAM)
llama-server \
  -m ~/gguf/qwen2.5-coder-32b-instruct-q4_k_m.gguf \
  --port 8080 \
  -ngl 99 \
  -c 32768 \
  --fa

 Qwen2.5-Coder (14B / 32B)
 default 32,768 tokens (32k)
 max : 131,072 tokens (128k)
 DeepSeek-R1-Distill-Qwen
 131,072 tokens (128k)

# Saves ~50% KV cache VRAM with virtually zero loss in quality
taskset -c 0-15 ~/git/llama.cpp/build/bin/llama-server \
  -m ~/gguf/qwen2.5-coder-32b-instruct-q4_k_m.gguf \
  -c 32768 \
  --cache-type-k q4_0 \
  --cache-type-v q4_0 \
  -ngl 99 \
  --flash-attn on


