
# llama


git clone https://github.com/ggml-org/llama.cpp
cd llama.cpp
cmake -B build -DGGML_CUDA=ON -DCUDA_ARCHITECTURES="86"
cmake --build build --config Release -j$(nproc) --target llama-cli
cmake --build build --config Release -j$(nproc) --target llama-server


qwen 2.5 not working with pi
need qwen 3

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

