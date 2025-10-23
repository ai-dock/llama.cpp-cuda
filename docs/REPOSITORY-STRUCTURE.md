# Repository Structure

```
ai-dock/llama.cpp-cuda/
├── .github/
│   ├── workflows/
│   │   └── build-cuda.yml          # Main CI/CD workflow for building with CUDA
│   └── ISSUE_TEMPLATE/
│       ├── bug_report.md            # Bug report template
│       └── feature_request.md       # Feature request template
│
├── docs/
│   ├── QUICKSTART.md               # Quick start guide for new users
│   ├── GPU-COMPATIBILITY.md         # Comprehensive GPU/CUDA compatibility reference
│   └── TROUBLESHOOTING.md          # Detailed troubleshooting guide
│
├── scripts/
│   ├── test-build.sh               # Local build testing script
│   └── check-releases.sh           # Check for new upstream releases
│
├── README.md                        # Main project documentation
├── LICENSE                          # MIT License
├── CONTRIBUTING.md                  # Contribution guidelines
└── .gitignore                      # Git ignore rules

```

## File Descriptions

### Core Files

#### `.github/workflows/build-cuda.yml`
The heart of the project. This GitHub Actions workflow:
- Runs daily at 00:00 UTC
- Checks for new llama.cpp releases
- Builds llama.cpp with CUDA for multiple versions
- Creates releases with binary artifacts
- Can be manually triggered

**Key features:**
- Matrix builds across 5 CUDA versions
- Architecture-specific compilation
- Automated release creation
- Artifact packaging

#### `README.md`
Main documentation covering:
- Project overview and purpose
- Supported CUDA versions and architectures
- Usage instructions
- System requirements
- Download and installation guide

### Documentation (`docs/`)

#### `QUICKSTART.md`
Step-by-step guide for new users:
1. Check GPU compatibility
2. Download binaries
3. Run first model
4. Common options and commands

Target audience: Users who want to get started immediately.

#### `GPU-COMPATIBILITY.md`
Comprehensive reference for:
- GPU architecture details
- Compute capability lookup
- CUDA/driver version requirements
- Compatibility matrix
- How to find your GPU info

Target audience: Users who need to verify compatibility or troubleshoot driver issues.

#### `TROUBLESHOOTING.md`
Detailed solutions for:
- Installation issues
- CUDA runtime problems
- Performance problems
- Build architecture issues
- Server issues

Target audience: Users experiencing problems.

### Scripts (`scripts/`)

#### `test-build.sh`
Allows local testing of the build process:
```bash
./scripts/test-build.sh [CUDA_VERSION] [LLAMA_TAG]
```

Features:
- Uses same Docker images as CI
- Validates CUDA version
- Creates test binaries locally
- Useful for development and debugging

#### `check-releases.sh`
Checks for new llama.cpp releases:
```bash
./scripts/check-releases.sh
```

Features:
- Compares upstream vs our latest release
- Shows when builds are needed
- Provides release links

### Issue Templates

#### `bug_report.md`
Structured template for bug reports with:
- System information collection
- Steps to reproduce
- Checklist for common issues
- Required context

#### `feature_request.md`
Template for enhancement suggestions with:
- Clear description format
- Use case explanation
- Implementation ideas
- Feasibility considerations

### Supporting Files

#### `LICENSE`
MIT License covering the build scripts and configuration.
Notes that llama.cpp binaries are under their own license.

#### `CONTRIBUTING.md`
Guidelines for contributors covering:
- How to report issues
- How to suggest improvements
- Development workflow
- Testing procedures
- Pull request process

#### `.gitignore`
Excludes from version control:
- Build artifacts
- Downloaded source
- Temporary files
- OS-specific files

## Workflow Details

### Build Process Flow

```
Scheduled Trigger (00:00 UTC) or Manual Trigger
              ↓
    Check for New Release
              ↓
      [New Release?] ━━━━━━━━━━━→ [No] → Exit
              ↓
            [Yes]
              ↓
    Build Matrix (5 CUDA versions)
              ↓
    ┌─────────┬─────────┬─────────┬─────────┬─────────┐
    │ 12.4.1  │ 12.6.3  │ 12.8.0  │ 12.9.0  │ 13.0.0  │
    └─────────┴─────────┴─────────┴─────────┴─────────┘
              ↓
    Docker Build with CUDA
              ↓
    Package as Tarballs
              ↓
    Upload Artifacts
              ↓
    Create GitHub Release
              ↓
    Tag Repository
```

### Architecture Selection Logic

```
CUDA 12.4.1, 12.6.3:
    Architectures: 75, 80, 86, 89, 90
    (No Blackwell support)

CUDA 12.8.0, 12.9.0, 13.0.0:
    Architectures: 75, 80, 86, 89, 90, 100
    (Includes Blackwell)
```

## Maintenance

### Regular Tasks

1. **Monitor upstream releases** (automated)
   - Workflow checks daily
   - Builds trigger automatically

2. **Update CUDA versions** (when needed)
   - Edit workflow matrix
   - Test with `test-build.sh`
   - Update documentation

3. **Review issues** (as needed)
   - Check for build problems
   - Update documentation based on common issues

4. **Update driver/CUDA compatibility tables** (quarterly)
   - Check NVIDIA documentation
   - Update GPU-COMPATIBILITY.md

### Future Enhancements

Potential improvements:
- Add support for ROCm (AMD GPUs)
- Build for other architectures (aarch64)
- Provide Docker images
- Add automated benchmarking
- Support for other GGML projects

## Best Practices

### When Adding New CUDA Versions

1. Verify CUDA Docker image exists
2. Check minimum driver requirements
3. Determine architecture support
4. Update all documentation
5. Test build locally first
6. Update workflow matrix
7. Update README tables

### When Modifying Build Process

1. Test locally with `test-build.sh`
2. Check disk space requirements
3. Verify all binaries are copied
4. Test tarball extraction
5. Validate binary execution
6. Update documentation if needed

### Documentation Updates

Keep these in sync:
- README.md architecture tables
- GPU-COMPATIBILITY.md compatibility matrix
- QUICKSTART.md driver requirements
- Workflow CUDA versions
