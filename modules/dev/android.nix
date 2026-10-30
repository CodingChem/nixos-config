{ config, lib, pkgs, ... }:
with lib;

let
  cfg = config.mySystem.dev;
in
{
  config = mkIf (cfg.enable && cfg.android.enable) {
    # 1. Install Android Studio & tools
    environment.systemPackages = with pkgs; [
      android-studio
      android-tools
    ];

    # 2. nix-ld bridges unpatched emulator and SDK binaries
    programs.nix-ld.enable = true;
    programs.nix-ld.libraries = with pkgs; [
      stdenv.cc.cc
      zlib
      glibc
      libxcrypt-legacy
      ncurses5
      libGL
      libsecret
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
  };
}
