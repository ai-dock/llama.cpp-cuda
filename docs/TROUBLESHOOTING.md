# Troubleshooting Guide

## Common Issues and Solutions

### Installation Issues

#### "Permission denied" when running binaries

**Problem:** Cannot execute the downloaded binaries.

**Solution:**
```bash
chmod +x llama-cli llama-server llama-bench
# Or make all files executable:
chmod +x *
```

#### Missing shared libraries

**Problem:** Error like `error while loading shared libraries: libcuda.so.1`

**Solution:**
```bash
# Verify CUDA installation
ldconfig -p | grep cuda

# If missing, install NVIDIA driver properly
# Ubuntu/Debian:
sudo apt-get install nvidia-driver-XXX

# Then update library cache
sudo ldconfig
```

### CUDA Runtime Issues

#### "CUDA driver version is insufficient for CUDA runtime version"

**Problem:** Your NVIDIA driver is too old for the CUDA version used to build the binary.

**Solutions:**
1. **Update your driver** (recommended):
   ```bash
   # Check current driver version
   nvidia-smi
   
   # Update driver (Ubuntu/Debian)
   sudo apt-get update
   sudo apt-get install nvidia-driver-550  # or higher
   ```

2. **Use an older CUDA build**:
   - Download a build with older CUDA version (e.g., 12.4.1 instead of 13.0.0)
   - See [GPU Compatibility Guide](GPU-COMPATIBILITY.md) for driver requirements

#### "no CUDA-capable device is detected"

**Problem:** llama.cpp cannot find your GPU.

**Diagnosis:**
```bash
# Check if GPU is visible
nvidia-smi

# Check if CUDA runtime is installed
nvcc --version

# Check if device is accessible
ls -la /dev/nvidia*
```

**Solutions:**
1. **Driver not loaded:**
   ```bash
   # Check if modules are loaded
   lsmod | grep nvidia
   
   # If not, load them
   sudo modprobe nvidia
   sudo modprobe nvidia_uvm
   ```

2. **Permissions issue:**
   ```bash
   # Add user to video group
   sudo usermod -a -G video $USER
   
   # Log out and back in
   ```

3. **Conflicting drivers:**
   ```bash
   # Remove nouveau driver (open-source, conflicts with NVIDIA)
   sudo bash -c "echo blacklist nouveau > /etc/modprobe.d/blacklist-nvidia-nouveau.conf"
   sudo update-initramfs -u
   sudo reboot
   ```

### Performance Issues

#### Slow inference speed

**Problem:** Model runs slower than expected.

**Checks:**
```bash
# Monitor GPU usage
nvidia-smi dmon

# Check which device is being used
./llama-cli -m model.gguf -p "test" --verbose
```

**Solutions:**
1. **Ensure CUDA is being used:**
   - Look for "CUDA" in startup output
   - Should show GPU memory allocation

2. **Check for thermal throttling:**
   ```bash
   nvidia-smi -q -d TEMPERATURE
   ```

3. **Try different quantization:**
   - Q8_0 or Q6_K for better speed
   - Q4_K_M for lower memory usage

4. **Adjust batch size:**
   ```bash
   ./llama-cli -m model.gguf --batch-size 512
   ```

#### Out of memory errors

**Problem:** `CUDA out of memory` or similar error.

**Solutions:**
1. **Check available VRAM:**
   ```bash
   nvidia-smi
   ```

2. **Use smaller model or quantization:**
   - Q4_K_M instead of Q8_0
   - Use smaller parameter model (7B instead of 13B)

3. **Reduce context size:**
   ```bash
   ./llama-cli -m model.gguf -c 2048  # instead of 4096
   ```

4. **Enable offloading:**
   ```bash
   ./llama-cli -m model.gguf -ngl 32  # offload 32 layers
   ```

### Build Architecture Issues

#### Model runs but performs poorly on newer GPU

**Problem:** You have a new GPU but downloaded wrong CUDA version.

**Solution:**
- RTX 40 series (8.9): Use any CUDA version
- H100 (9.0): Use CUDA 12.8+ for best performance
- Blackwell (10.0): **MUST** use CUDA 12.8 or higher

Download the appropriate build from releases.

#### "no kernel image is available for execution"

**Problem:** Binary was not built with support for your GPU architecture.

**Check your compute capability:**
```bash
nvidia-smi --query-gpu=compute_cap --format=csv,noheader
```

**Solution:**
Ensure you downloaded a build that supports your architecture:
- Compute 7.5, 8.0, 8.6, 8.9, 9.0: Any CUDA version
- Compute 10.0 (Blackwell): CUDA 12.8+ only

### Server Issues

#### Server won't bind to port

**Problem:** `Address already in use`

**Solution:**
```bash
# Find what's using the port
sudo lsof -i :8080

# Use different port
./llama-server -m model.gguf --port 8081
```

#### Server crashes immediately

**Check logs:**
```bash
./llama-server -m model.gguf --verbose 2>&1 | tee server.log
```

**Common causes:**
1. Invalid model path
2. Insufficient memory
3. CUDA driver issues (see above)

### File and Model Issues

#### "invalid model file"

**Problem:** Model file is corrupted or incompatible.

**Solutions:**
1. **Verify download:**
   ```bash
   # Check file integrity if hash provided
   sha256sum model.gguf
   ```

2. **Re-download model**

3. **Check format:**
   - Ensure it's a `.gguf` file
   - Old `.bin` format not supported in newer llama.cpp

#### Very slow model loading

**Problem:** Model takes minutes to load.

**Solutions:**
1. **Use SSD instead of HDD**
2. **Increase system memory**
3. **Use `mlock` to keep in RAM:**
   ```bash
   ./llama-cli -m model.gguf --mlock
   ```

## Getting Help

### Collect diagnostic information

When asking for help, provide:

```bash
# System info
uname -a
lsb_release -a

# GPU info
nvidia-smi

# CUDA driver
cat /proc/driver/nvidia/version

# File info
cat VERSION.txt

# Error output
./llama-cli -m model.gguf --verbose 2>&1 | tee error.log
```

### Where to ask

- **Build issues:** Open issue in this repository
- **llama.cpp functionality:** [llama.cpp issues](https://github.com/ggml-org/llama.cpp/issues)
- **CUDA/driver issues:** [NVIDIA Developer Forums](https://forums.developer.nvidia.com/)

## Additional Resources

- [GPU Compatibility Guide](GPU-COMPATIBILITY.md)
- [llama.cpp Documentation](https://github.com/ggml-org/llama.cpp/tree/master/docs)
- [NVIDIA CUDA Troubleshooting](https://docs.nvidia.com/cuda/cuda-installation-guide-linux/)
