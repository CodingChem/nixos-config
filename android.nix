{ pkgs, ... }:

{
  # 1. Install Android Studio
  environment.systemPackages = with pkgs; [
    android-studio
    android-tools
  ];

  # 3. Essential for the Emulator and SDK binaries
  # This bridges the gap for unpatched binaries downloaded by the IDE
  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    stdenv.cc.cc
    zlib
    glibc
    libxcrypt-legacy
    ncurses5
    libGL
    libsecret
    # These are often required by the emulator/layout inspector
    nspr
    nss
    expat
    libX11
    libXcomposite
    libXcursor
    libXdamage
    libXext
    libXfixes
    libXi
    libXrender
    libXtst
    libxcb
  ];
}
