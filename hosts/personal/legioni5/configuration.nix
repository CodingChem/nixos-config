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

  environment.systemPackages = with pkgs; [ 
    wl-clipboard 
    waybar 
    fuzzel    # Launcher
    alacritty # Terminal
  ];

  # --- SYSTEM VERSION ---
  system.stateVersion = "25.11"; 
}
