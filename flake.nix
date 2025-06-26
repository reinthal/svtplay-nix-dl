{
  description = "SVTPlay Nix downloader with Python environment";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = {
    self,
    nixpkgs,
    flake-utils,
  }:
    flake-utils.lib.eachDefaultSystem (
      system: let
        pkgs = nixpkgs.legacyPackages.${system};
      in {
        packages.default = pkgs.writeShellScriptBin "svtplay-nix-dl" ''
          export PATH="${pkgs.svtplay-dl}/bin:${pkgs.ffmpeg}/bin:$PATH"
          exec ${pkgs.svtplay-dl}/bin/svtplay-dl "$@"
        '';

        default = pkgs.mkShell {
          buildInputs = [pkgs.svtplay-dl pkgs.ffmpeg];

          shellHook = ''
            echo "SVTPlay-dl environment ready"
            echo "FFmpeg: $(ffmpeg -version | head -n1)"
            echo "svtplay-dl: $(svtplay-dl --version)"
          '';
        };
      }
    );
}
