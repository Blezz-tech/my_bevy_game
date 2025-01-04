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
    udev
    alsa-lib
    vulkan-loader

    # advanced
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
  LD_LIBRARY_PATH = lib.makeLibraryPath buildInputs;
}
