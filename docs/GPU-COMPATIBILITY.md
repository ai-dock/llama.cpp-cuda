# GPU Compatibility Reference

## Finding Your GPU's Compute Capability

### Method 1: Using nvidia-smi

```bash
nvidia-smi --query-gpu=name,compute_cap --format=csv
```

### Method 2: Check NVIDIA Documentation

Visit: https://developer.nvidia.com/cuda-gpus

### Method 3: Using PyTorch (if installed)

```python
import torch
if torch.cuda.is_available():
    print(f"GPU: {torch.cuda.get_device_name(0)}")
    print(f"Compute Capability: {torch.cuda.get_device_capability(0)}")
```

## Compute Capability Breakdown

### 7.5 (Turing)
- Tesla T4
- GeForce RTX 2060, 2070, 2080, 2080 Ti
- Quadro RTX 4000, 5000, 6000, 8000
- GeForce GTX 1650, 1660 series

**CUDA Support:** 12.4+

### 8.0 (Ampere - Data Center)
- NVIDIA A100
- NVIDIA A30

**CUDA Support:** 12.4+

### 8.6 (Ampere - Consumer/Pro)
- GeForce RTX 3050, 3060, 3070, 3080, 3090
- RTX A2000, A4000, A5000, A6000
- NVIDIA A10, A40

**CUDA Support:** 12.4+

### 8.9 (Ada Lovelace / Hopper L-series)
- GeForce RTX 4060, 4070, 4080, 4090
- RTX 6000 Ada
- NVIDIA L4, L40, L40S

**CUDA Support:** 12.4+

### 9.0 (Hopper)
- NVIDIA H100
- NVIDIA H200

**CUDA Support:** 12.4+

### 10.0 (Blackwell)
- NVIDIA B100
- NVIDIA B200
- NVIDIA GB200

**CUDA Support:** 12.8+ (minimum)

## Minimum CUDA Driver Versions

| CUDA Toolkit | Minimum Driver (Linux) | Minimum Driver (Windows) |
|--------------|------------------------|--------------------------|
| 12.4         | 550.54.15             | 552.22                   |
| 12.6         | 560.28.03             | 561.09                   |
| 12.8         | 570.15                | 571.00                   |
| 12.9         | 580.13                | 581.00                   |
| 13.0         | 590.xx                | 591.xx                   |

## Checking Your Driver Version

### Linux
```bash
nvidia-smi
# or
cat /proc/driver/nvidia/version
```

### Windows
```cmd
nvidia-smi
```

## CUDA Compatibility Matrix

| GPU Architecture | Compute Cap. | CUDA 12.4 | CUDA 12.6 | CUDA 12.8 | CUDA 12.9 | CUDA 13.0 |
|-----------------|--------------|-----------|-----------|-----------|-----------|-----------|
| Turing          | 7.5          | ✅        | ✅        | ✅        | ✅        | ✅        |
| Ampere (DC)     | 8.0          | ✅        | ✅        | ✅        | ✅        | ✅        |
| Ampere          | 8.6          | ✅        | ✅        | ✅        | ✅        | ✅        |
| Ada/Hopper-L    | 8.9          | ✅        | ✅        | ✅        | ✅        | ✅        |
| Hopper          | 9.0          | ✅        | ✅        | ✅        | ✅        | ✅        |
| Blackwell       | 10.0         | ❌        | ❌        | ✅        | ✅        | ✅        |

## Recommendations by Use Case

### Personal Desktop/Workstation (RTX 20/30/40 series)
**Recommended:** CUDA 12.6.3 or 12.8.0
- Widest driver compatibility
- Stable and well-tested
- Supports all desktop GPUs

### Data Center (A100, H100)
**Recommended:** CUDA 12.8.0 or 12.9.0
- Latest optimizations for data center GPUs
- Better performance for Hopper architecture

### Latest Hardware (Blackwell)
**Required:** CUDA 12.8.0 or higher
- Blackwell architecture requires CUDA 12.8+
- Use CUDA 13.0 for latest features

### Maximum Compatibility (Older GPUs)
**Recommended:** CUDA 12.4.1
- Supports older drivers
- Good for Tesla T4 and RTX 20 series

## Troubleshooting

### "CUDA driver version is insufficient"
- Update your NVIDIA driver to meet minimum requirements
- Or download a build with an older CUDA version

### "No CUDA-capable device detected"
- Check if GPU is properly installed: `nvidia-smi`
- Verify NVIDIA driver is loaded: `lsmod | grep nvidia`
- Check PCIe connection if recent hardware changes

### Performance issues
- Ensure correct CUDA version for your GPU architecture
- For Hopper/Blackwell, use CUDA 12.8+
- Check GPU utilization: `nvidia-smi dmon`

### Binary not found
- Verify you extracted the entire tarball
- Check permissions: `chmod +x llama-*`
- Ensure you're in the correct directory

## Additional Resources

- [NVIDIA CUDA Compatibility Guide](https://docs.nvidia.com/cuda/cuda-toolkit-release-notes/)
- [GPU Compute Capability Table](https://developer.nvidia.com/cuda-gpus)
- [NVIDIA Driver Downloads](https://www.nvidia.com/download/index.aspx)
