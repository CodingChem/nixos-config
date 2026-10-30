{ config, pkgs, ... }:

{
  imports = [ 
    ./hardware-configuration.nix 
  ];

  # --- BOOTLOADER ---
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.timeout = 1;
  
  # --- SYSTEM SETUP ---
  services.fwupd.enable = true;
  zramSwap.enable = true;

  # --- SWAP & POWER ---
  boot.resumeDevice = "/dev/disk/by-uuid/feedd2a5-1513-4745-970e-0c8993f9fb32";
  boot.kernelParams = [ "resume=UUID=feedd2a5-1513-4745-970e-0c8993f9fb32" ];
  powerManagement.enable = true;

  # --- HARDWARE ---
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };

  # --- DESKTOP PROFILE ---
  myDesktop = {
    enable = true;
    environment = "gnome";
  };

  # --- SYSTEM CAPABILITIES ---
  mySystem.dev.enable = true;

  # --- SYSTEM VERSION ---
  system.stateVersion = "25.11";
}
