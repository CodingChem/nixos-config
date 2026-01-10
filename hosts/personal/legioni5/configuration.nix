{ config, pkgs, ... }:

{
  imports = [ 
    ./hardware-configuration.nix
    # ./bluetooth.nix
  ];

  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # --- SYSTEM SETUP ---

  networking.hostName = "legioni5";
  networking.networkmanager.enable = true;

  # Lyd (Pipewire)
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };
{ pkgs, ... }: {
  # Enable Niri System-Wide (Registers session in GDM)
  programs.niri.enable = true;

  # Ensure you have a wayland-compatible terminal/launcher available system-wide or in user profile
  # (We will configure them in Home Manager, but good to have)
  environment.systemPackages = with pkgs; [ 
    wl-clipboard 
    waybar 
    fuzzel   # A lightweight launcher, great for Niri
    alacritty # or your preferred terminal
  ];

  # Nvidia 50-series specific (Standard Wayland setup)
  # Your 5070Ti handles explicit sync well, so we just need modesetting.
  hardware.nvidia = {
    modesetting.enable = true;
    open = true; # Use open kernel modules if on driver 560+
  };
}

  # Standard NixOS versjon
  system.stateVersion = "25.11";
}
