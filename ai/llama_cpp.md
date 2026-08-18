
# llama

host
Core i7-12700KF, 1x RTX 3090 24GB, 128GB RAM 

## Usage

~~~bash
curl http://localhost:888/v1/models | jq . # see available models
~~~

start
~~~bash
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
  --port 8888


# Saves ~50% KV cache VRAM with virtually zero loss in quality
taskset -c 0-15 ~/git/llama.cpp/build/bin/llama-server \
  -m ~/gguf/qwen2.5-coder-32b-instruct-q4_k_m.gguf \
  -c 32768 \
  --cache-type-k q4_0 \
  --cache-type-v q4_0 \
  -ngl 99 \
  --flash-attn on

~~~

## Compile
~~~
git clone https://github.com/ggml-org/llama.cpp
cd llama.cpp
cmake -B build -DGGML_CUDA=ON -DCUDA_ARCHITECTURES="86"
cmake --build build --config Release -j$(nproc) --target llama-cli
cmake --build build --config Release -j$(nproc) --target llama-server
~~~

## Get models

~~~
mkdir ~/gguf
hf download Qwen/Qwen2.5-Coder-32B-Instruct-GGUF \
  --include "*q4_k_m*.gguf" \
  --local-dir ~/gguf

hf download unsloth/DeepSeek-R1-Distill-Qwen-32B-GGUF \
  --include "*Q4_K_M*.gguf" \
  --local-dir ~/gguf
~~~

llama serve \
 -hf  ggml-org/Qwen3.8-27B-GGUF:Q4_K_M \
 -hfd ggml-org/Qwen3.8-27B-GGUF:Q4_0 \
 --spec-default \
 --spec-type draft-mtp \
 --reasoning-preserve




