{ pkgs ? import <nixpkgs> { } }:

with pkgs;

mkShell rec {
  nativeBuildInputs = [
    pkg-config
  ];
  buildInputs = with pkgs; [
    cargo
    rustc
    rust-analyzer
    rustfmt

    # Bevy
    alsa-lib
    udev
    clang
    lld
    mold

    # Maybe not requires
    # vulkan-tools
    # vulkan-headers
    # vulkan-loader
    # vulkan-validation-layers

    # If on X11
    xorg.libX11
    xorg.libXcursor
    xorg.libXi
    xorg.libXrandr

    # If on Wayland
    libxkbcommon
    wayland
  ];
  RUST_SRC_PATH = rustPlatform.rustLibSrc;

  shellHook = ''
    export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:${pkgs.lib.makeLibraryPath [
      pkgs.alsa-lib
      pkgs.udev
      pkgs.vulkan-loader
      pkgs.libxkbcommon
    ]}"
  '';

}
