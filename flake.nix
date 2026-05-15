{
  description = "llama.cpp CUDA binaries from ai-dock (Patched for NixOS)";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs {
          inherit system;
          config.allowUnfree = true; # Required for CUDA
        };
        release = builtins.fromJSON (builtins.readFile ./latest_release.json);
        sha256 = builtins.convertHash {
          hash = release.hash;
          toHashFormat = "sri";
          hashAlgo = "sha256";
        };
      in
      {
        packages.default =
          with release;
          pkgs.stdenv.mkDerivation {
            pname = "aidock_llama-cpp-cuda";
            inherit version;
            src = pkgs.fetchurl { inherit url sha256; };
            nativeBuildInputs = with pkgs; [ autoPatchelfHook ];
            buildInputs = with pkgs; [
              stdenv.cc.cc.lib
              cudaPackages.cudatoolkit
              cudaPackages.nccl
              linuxPackages.nvidia_x11
            ];

            appendRunpaths = [
              "/run/opengl-driver/lib"
              "${pkgs.linuxPackages.nvidia_x11}/lib"
              "$out/lib"
            ];

            sourceRoot = ".";

            installPhase = ''
              mkdir -p $out/bin $out/lib
              find . -name "*.so*" -exec cp -vP {} $out/lib/ \;
              find . -type f -executable \
                ! -name "*.so*" \
                ! -name "*.txt" \
                ! -name "*.md" \
                -exec cp -v {} $out/bin/ \;
              [ "$(ls -A $out/bin)" ] || { echo "Error: No binaries found!"; exit 1; }
            '';
            autoPatchelfIgnoreMissingDeps = false;
          };
        devShells.default = pkgs.mkShell {
          buildInputs = [ self.packages.${system}.default ];
          shellHook = ''
            export LD_LIBRARY_PATH="/run/opengl-driver/lib:${pkgs.linuxPackages.nvidia_x11}/lib:$LD_LIBRARY_PATH"
          '';
        };
      }
    );
}
