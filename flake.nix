{
  description = "SVTPlay Nix downloader with Python environment";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        pythonEnv = pkgs.python312.withPackages (ps: with ps; [
          pip
          (ps.buildPythonPackage rec {
            pname = "svtplay-dl";
            version = "4.99.2";
            src = ps.fetchPypi {
              inherit pname version;
              sha256 = "sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=";
            };
            doCheck = false;
          })
        ]);
      in
      {
        packages.default = pkgs.stdenv.mkDerivation {
          name = "svtplay-nix-dl";
          buildInputs = [ pythonEnv pkgs.ffmpeg ];
          
          src = ./.;
          
          installPhase = ''
            mkdir -p $out/bin
            
            # Install Python dependencies from requirements.txt
            ${pythonEnv}/bin/pip install --prefix $out -r requirements.txt
            
            # Make ffmpeg available
            ln -s ${pkgs.ffmpeg}/bin/ffmpeg $out/bin/
          '';
        };
        
        devShells.default = pkgs.mkShell {
          buildInputs = [ pythonEnv pkgs.ffmpeg ];
          
          shellHook = ''
            echo "SVTPlay development environment loaded"
            echo "Python: $(python --version)"
            echo "FFmpeg: $(ffmpeg -version | head -n1)"
            
            # Install requirements if they exist
            if [ -f requirements.txt ]; then
              pip install -r requirements.txt
            fi
          '';
        };
      }
    );
}
