#!/usr/bin/env bash
curl -s https://api.github.com/repos/ai-dock/llama.cpp-cuda/releases/latest | jq '{version:(.tag_name),hash:(.assets[0].digest),url:(.assets[0].browser_download_url)}' > latest_release.json
nix flake update
