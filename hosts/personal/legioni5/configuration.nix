{ config, pkgs, ... }:

{
  imports = [ 
    ./hardware-configuration.nix
    # ./bluetooth.nix
  ];

  # --- BOOTLOADER ---
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # --- SYSTEM SETUP ---
  networking.hostName = "legioni5";
  networking.networkmanager.enable = true;

  # --- AUDIO (Pipewire) ---
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # --- NIRI & GRAPHICS SETUP ---
  
  # Enable Niri System-Wide (Registers session in GDM)
  programs.niri.enable = true;

  # Basic system packages for Wayland
  environment.systemPackages = with pkgs; [ 
    wl-clipboard 
    waybar 
    fuzzel    # Launcher
    alacritty # Terminal
  ];

  # --- NVIDIA RTX 5070Ti CONFIGURATION ---
  
  # 1. Enable OpenGL/Vulkan
  hardware.graphics = {
    enable = true;
    enable32Bit = true; # Useful for Steam/Games
  };

  # 2. Tell NixOS to load the Nvidia driver
  services.xserver.videoDrivers = [ "nvidia" ];

  # 3. Configure the Nvidia driver settings
  hardware.nvidia = {
    # Modesetting is required for Wayland
    modesetting.enable = true;

    # Use the open source kernel module (Recommended for 50-series)
    open = true;

    # Nvidia power management
    powerManagement.enable = false;
    powerManagement.finegrained = false;

    # Use beta drivers for the 5070Ti to ensure support
    package = config.boot.kernelPackages.nvidiaPackages.beta; 
  };

  # --- SYSTEM VERSION ---
  system.stateVersion = "25.11"; 
}
