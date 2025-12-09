{
  description = "Rust + egui dev environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in
      {
        devShells.default = pkgs.mkShell {
          LD_LIBRARY_PATH = pkgs.lib.makeLibraryPath [
            pkgs.wayland
            pkgs.libxkbcommon

            pkgs.xorg.libX11
            pkgs.xorg.libXcursor
            pkgs.xorg.libXi
            pkgs.xorg.libXrandr

            pkgs.mesa
            pkgs.mesa.drivers
            pkgs.libglvnd
            pkgs.libdrm

            pkgs.vulkan-loader
          ];

          buildInputs = [
            pkgs.pkg-config

            pkgs.wayland
            pkgs.wayland-protocols
            pkgs.libxkbcommon

            pkgs.xorg.libX11
            pkgs.xorg.libXcursor
            pkgs.xorg.libXi
            pkgs.xorg.libXrandr

            pkgs.mesa # GL, EGL
            pkgs.libglvnd # OpenGL loader
            pkgs.mesa.drivers # DRI 驱动 (要加这个 glutin 才能工作)
            pkgs.libdrm

            pkgs.vulkan-loader
          ];

          RUST_BACKTRACE = 1;

        };
      }
    );
}
