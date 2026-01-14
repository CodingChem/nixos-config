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

  # Grafikkinnstillinger
  hardware.graphics = {
    enable = true;
    enable32Bit = true; # Påkrevd for Steam
  };

  # Last Nvidia-driveren
  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
    # Påkrevd for Wayland/GNOME
    modesetting.enable = true;

    # Strømstyring for laptoper
    powerManagement.enable = true;
    powerManagement.finegrained = true; # Bedre strømsparing på 50-serien

    # Bruk den åpne drivermodulen (anbefalt for 5070 Ti)
    open = true;

    # Bruk stabil produksjonsdriver
    package = config.boot.kernelPackages.nvidiaPackages.stable;

    # PRIME-oppsett (Hybrid grafikk)
    prime = {
      offload = {
        enable = true;
        enableOffloadCmd = true;
      };
      # Basert på din lspci:
      intelBusId = "PCI:0:2:0";
      nvidiaBusId = "PCI:2:0:0";
    };
  };

  # Fix for Intel Arrow Lake integrert grafikk
  boot.kernelParams = [ "i915.force_probe=7f2f" ];
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
