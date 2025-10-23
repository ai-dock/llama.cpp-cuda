# Contributing to llama.cpp-cuda

Thank you for your interest in contributing to this project!

## How to Contribute

### Reporting Issues

If you encounter problems with the built binaries:

1. Check the [Issues](../../issues) page to see if it's already reported
2. If not, create a new issue with:
   - Your GPU model and compute capability
   - CUDA version you're using
   - Driver version
   - The exact error message or behavior
   - Steps to reproduce

### Suggesting Improvements

We welcome suggestions for:
- Additional CUDA versions to support
- Architecture optimizations
- Build process improvements
- Documentation enhancements

## Development

### Testing Builds Locally

Use the provided test script to build locally:

```bash
./scripts/test-build.sh 12.6.3
```

### Modifying Build Configuration

The main build configuration is in `.github/workflows/build-cuda.yml`:

**To add a new CUDA version:**

1. Add it to the `matrix.cuda_version` array
2. Add corresponding `cuda_tag` (Docker image tag)
3. Add appropriate `architectures` list

**To change supported architectures:**

Modify the `architectures` field in the matrix. Format: semicolon-separated list (e.g., `75;80;86`).

### Architecture Guidelines

- **Always include** 7.5+ for wide compatibility
- **Blackwell (10.0)** only for CUDA >= 12.8
- Test on at least one GPU from each architecture if possible

### Pull Request Process

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/improvement`)
3. Make your changes
4. Test locally if possible
5. Commit with clear messages
6. Push to your fork
7. Open a Pull Request with:
   - Clear description of changes
   - Reason for the change
   - Any testing performed

### Code Style

- Use clear, descriptive variable names
- Comment complex logic
- Follow existing formatting patterns
- Keep shell scripts POSIX-compatible where possible

## Release Process

Releases are automated:
1. Workflow checks for new llama.cpp releases daily
2. If found, builds for all CUDA versions
3. Creates GitHub release with binaries
4. Tags repository with llama.cpp version

Manual releases can be triggered via GitHub Actions.

## Questions?

Feel free to open a discussion or issue if you have questions about contributing.

## License

By contributing, you agree that your contributions will be licensed under the MIT License.
