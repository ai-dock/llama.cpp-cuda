# Quick Start Guide

Get up and running with llama.cpp CUDA binaries in 5 minutes.

## Prerequisites

1. NVIDIA GPU (compute capability 7.5 or higher)
2. NVIDIA driver installed (check with `nvidia-smi`)
3. Linux x86_64 system (Ubuntu 22.04 or compatible)

## Step 1: Check Your GPU

```bash
nvidia-smi --query-gpu=name,compute_cap --format=csv
```

This shows your GPU name and compute capability. Make sure it's 7.5 or higher.

## Step 2: Check Your Driver

```bash
nvidia-smi | grep "Driver Version"
```

Compare against [minimum driver versions](GPU-COMPATIBILITY.md#minimum-cuda-driver-versions):
- CUDA 12.4: Driver >= 550.54
- CUDA 12.6: Driver >= 560.28  ← **Recommended for most users**
- CUDA 12.8: Driver >= 570.15
- CUDA 12.9: Driver >= 580.13

**If your driver is too old, download an older CUDA version or update your driver.**

## Step 3: Download Binaries

1. Go to [Releases](../../releases/latest)
2. Download the tarball for your CUDA version, e.g.:
   ```bash
   wget https://github.com/ai-dock/llama.cpp-cuda/releases/download/bXXXX/llama.cpp-bXXXX-cuda-12.6.3.tar.gz
   ```

**Not sure which version?** Use CUDA 12.6.3 for most systems.

## Step 4: Extract

```bash
tar -xzf llama.cpp-bXXXX-cuda-12.6.3.tar.gz
cd cuda-12.6.3
```

## Step 5: Download a Model

Get a GGUF model (e.g., from [Hugging Face](https://huggingface.co/models?library=gguf)):

```bash
# Example: Download a 7B model
wget https://huggingface.co/TheBloke/Llama-2-7B-GGUF/resolve/main/llama-2-7b.Q4_K_M.gguf
```

## Step 6: Run!

### Simple Chat
```bash
./llama-cli -m llama-2-7b.Q4_K_M.gguf -p "Hello, how are you?"
```

### Interactive Chat
```bash
./llama-cli -m llama-2-7b.Q4_K_M.gguf --interactive
```

### Start Server
```bash
./llama-server -m llama-2-7b.Q4_K_M.gguf
# Then visit http://localhost:8080 in your browser
```

## Common Options

### Adjust GPU Offloading
```bash
# Offload all layers to GPU (faster)
./llama-cli -m model.gguf -ngl 999

# Offload specific number of layers
./llama-cli -m model.gguf -ngl 32
```

### Change Context Size
```bash
# Use 4K context
./llama-cli -m model.gguf -c 4096

# Use 2K context (saves memory)
./llama-cli -m model.gguf -c 2048
```

### Adjust Temperature
```bash
# More creative (higher temperature)
./llama-cli -m model.gguf --temp 0.9

# More focused (lower temperature)
./llama-cli -m model.gguf --temp 0.5
```

### Set Seed for Reproducibility
```bash
./llama-cli -m model.gguf --seed 42
```

## Verify CUDA is Working

You should see output like:
```
ggml_cuda_init: GGML_CUDA_FORCE_MMQ:   no
ggml_cuda_init: CUDA_USE_TENSOR_CORES: yes
ggml_cuda_init: found 1 CUDA devices:
  Device 0: NVIDIA GeForce RTX 3090, compute capability 8.6
```

If you see this, CUDA is working! 🎉

## Troubleshooting

### "CUDA driver version is insufficient"
Your driver is too old. Either:
- Update driver: `sudo apt-get install nvidia-driver-XXX`
- Or download older CUDA build (e.g., 12.4.1)

### "no CUDA-capable device is detected"
```bash
# Check if GPU is visible
nvidia-smi

# Load NVIDIA modules if needed
sudo modprobe nvidia
```

### Out of memory
- Use smaller model (7B instead of 13B)
- Use more aggressive quantization (Q4_K_M instead of Q8_0)
- Reduce context: `-c 2048`
- Offload fewer layers: `-ngl 32`

### More help
See the [Troubleshooting Guide](TROUBLESHOOTING.md) for detailed solutions.

## Next Steps

- 📖 Read the [full documentation](../README.md)
- 🔧 Check [GPU compatibility](GPU-COMPATIBILITY.md)
- 🎯 Learn more [llama.cpp options](https://github.com/ggml-org/llama.cpp/blob/master/examples/main/README.md)
- 🚀 Run the [server](https://github.com/ggml-org/llama.cpp/tree/master/examples/server)

## Benchmark Your Setup

```bash
# Run benchmark
./llama-bench -m model.gguf

# Save results
./llama-bench -m model.gguf -o json > benchmark.json
```

## Getting Help

- Build issues: [Open an issue](../../issues)
- llama.cpp questions: [llama.cpp discussions](https://github.com/ggml-org/llama.cpp/discussions)

Happy prompting! 🦙
