{ pkgs, ... }:

{
  imports = [
    ./android.nix
  ];
  virtualisation.docker = {
    enable = true;
  };
}
