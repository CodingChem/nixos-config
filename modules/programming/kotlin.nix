{ config, pkgs, ... }:

{
  # Apps
  home.packages = with pkgs; [
    android-studio-full
    jetbrains.idea
  ];
}
