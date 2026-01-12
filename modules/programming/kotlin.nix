{ config, pkgs, ... }:

{
  # Apps
  environment.systemPackages = with pkgs; [
    android-studio-full
    jetbrains.idea
  ];
}
