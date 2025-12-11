{
  description = "eframe devShell";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
      in
      with pkgs; {
        devShells.default = mkShell rec {
          buildInputs = [
            # misc. libraries
            openssl
            pkg-config

            # GUI libs
            libxkbcommon
            libGL
            fontconfig

            # wayland libraries
            wayland

            # x11 libraries
            xorg.libXcursor
            xorg.libXrandr
            xorg.libXi
            xorg.libX11

          ];

          LD_LIBRARY_PATH = "${lib.makeLibraryPath buildInputs}";
        };
      });
}
