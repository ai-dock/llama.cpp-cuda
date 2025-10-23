# llama.cpp CUDA Builds

This repository automatically builds [llama.cpp](https://github.com/ggml-org/llama.cpp) with CUDA support for multiple NVIDIA GPU architectures and CUDA versions.

## Why This Repository?

The official llama.cpp repository does not provide pre-built CUDA binaries. This repository fills that gap by:

- Building llama.cpp with CUDA support for multiple CUDA toolkit versions
- Supporting a wide range of NVIDIA GPU architectures (compute capability 7.5+)
- Automatically tracking upstream llama.cpp releases
- Providing ready-to-use binaries via GitHub releases

## Supported Configurations

### CUDA Versions
- CUDA 12.4.1
- CUDA 12.6.3
- CUDA 12.8.1
- CUDA 12.9.1
- CUDA 13.0.1

### GPU Architectures

| Compute Capability | GPU Examples | CUDA 12.4/12.6 | CUDA 12.8+ |
|-------------------|--------------|----------------|------------|
| 7.5 | Tesla T4, RTX 2000 series, Quadro RTX | ✅ | ✅ |
| 8.0 | A100 | ✅ | ✅ |
| 8.6 | RTX 3000 series | ✅ | ✅ |
| 8.9 | RTX 4000 series, L4, L40 | ✅ | ✅ |
| 9.0 | H100, H200 | ✅ | ✅ |
| 10.0 | B100, B200, GB200 | ❌ | ✅ |
| 12.0 | RTX Pro series, RTX 5000 series | ❌ | ✅ |

**Note:** Blackwell architectures (10.0 & 12.0) require CUDA 12.8 or later.

## Usage

### Download

1. Go to the [Releases](../../releases) page
2. Download the tarball for your CUDA version (e.g., `llama.cpp-bXXXX-cuda-12.6.3.tar.gz`)
3. Extract the archive:

```bash
tar -xzf llama.cpp-bXXXX-cuda-12.6.3.tar.gz
cd cuda-12.6.3
```

### Run

The extracted directory contains all llama.cpp binaries:

```bash
# Run the main CLI
./llama-cli --help

# Run the server
./llama-server --help

# Other utilities
./llama-bench
./llama-quantize
./llama-embedding
```

### Check Version

Each release includes a `VERSION.txt` file with build information:

```bash
cat VERSION.txt
```

## System Requirements

- NVIDIA GPU with compute capability 7.5 or higher
- Appropriate NVIDIA driver for your CUDA version:
  - CUDA 12.4: Driver >= 550.54
  - CUDA 12.6: Driver >= 560.28
  - CUDA 12.8: Driver >= 570.15
  - CUDA 12.9: Driver >= 580.13
  - CUDA 13.0: Driver >= 590.xx
- Linux x86_64 (Ubuntu 22.04 compatible)

## Build Process

Builds are triggered automatically:
- Daily at 00:00 UTC
- Only if a new llama.cpp release is detected
- Can be manually triggered via GitHub Actions

Each build:
1. Checks for new llama.cpp releases
2. Clones llama.cpp at the exact release commit
3. Builds with CMake using CUDA Docker images
4. Packages binaries for each CUDA version
5. Creates a GitHub release with all build artifacts

## Choosing Your CUDA Version

Select based on:
1. **Your GPU architecture** - Blackwell GPUs require CUDA 12.8+
2. **Your installed CUDA toolkit** - Match the version if possible
3. **Your NVIDIA driver** - Ensure your driver supports the CUDA version

If unsure, CUDA 12.6.3 offers the widest compatibility with modern GPUs (except Blackwell).

## Manual Building

If you need a custom build:

```bash
git clone https://github.com/ai-dock/llama.cpp-cuda
cd llama.cpp-cuda

# Edit .github/workflows/build-cuda.yml to customize architectures or CUDA versions
# Then trigger a manual workflow run
```

## License

This repository contains build scripts only. The llama.cpp binaries are subject to the [llama.cpp MIT License](https://github.com/ggml-org/llama.cpp/blob/master/LICENSE).

## Links

- **Upstream llama.cpp**: https://github.com/ggml-org/llama.cpp
- **CUDA Toolkit**: https://developer.nvidia.com/cuda-toolkit
- **NVIDIA Driver Downloads**: https://www.nvidia.com/download/index.aspx

## Support

For issues with:
- **Build process or binaries**: Open an issue in this repository
- **llama.cpp functionality**: Open an issue in the [upstream repository](https://github.com/ggml-org/llama.cpp/issues)

## Credits

- [llama.cpp](https://github.com/ggml-org/llama.cpp) by Georgi Gerganov and contributors
- Built and maintained by [ai-dock](https://github.com/ai-dock)
