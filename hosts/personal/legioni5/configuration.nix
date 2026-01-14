{ config, pkgs, ... }:

{
  imports = [ 
    ./hardware-configuration.nix
    ./bluetooth.nix
  ];

  # --- BOOTLOADER ---
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # --- SYSTEM SETUP ---
  networking.hostName = "legioni5";
  networking.networkmanager.enable = true;
  services.fwupd.enable = true;

  # --- AUDIO (Pipewire) ---
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };
    # Terminal emulator
    programs = {
    ghostty = {
      enable = true;
      enableZshIntegration = true;
      settings = {
        theme = "Catppuccin Mocha";
	font-family = "JetBrainsMono Nerd Font";
	font-size = 12;
	window-decoration = false;
	background-opacity = 0.9;
      };
    };
    };
  environment.systemPackages = with pkgs; [ 
  ];
  # --- Docker ---
  virtualisation.docker.enable = true;

  # --- SYSTEM VERSION ---
  system.stateVersion = "25.11"; 
}
