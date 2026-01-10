{ config, pkgs, ... }:

{
  imports = [ 
    ./hardware-configuration.nix
    ./bluetooth.nix
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

  # Standard NixOS versjon
  system.stateVersion = "25.11";
}
