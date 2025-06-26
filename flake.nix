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
        pythonEnv = pkgs.python312.withPackages (ps:
          with ps; [
            pip
          ]);
      in {
        packages.default = pkgs.stdenv.mkDerivation {
          name = "svtplay-nix-dl";
          buildInputs = [pythonEnv pkgs.ffmpeg];

          src = ./.;

          installPhase = ''
            mkdir -p $out/bin
            pip install -r ./requirements.txt

            # Make ffmpeg available
            ln -s ${pkgs.ffmpeg}/bin/ffmpeg $out/bin/
          '';
        };

        default = pkgs.mkShell {
          buildInputs = [pythonEnv pkgs.ffmpeg];

          shellHook = ''
            echo "SVTPlay-dl "
            echo "Python: $(python --version)"
            echo "FFmpeg: $(ffmpeg -version | head -n1)"
            echo "svtplay-dl: $(svtplay-dl --version)
          '';
        };
      }
    );
}
