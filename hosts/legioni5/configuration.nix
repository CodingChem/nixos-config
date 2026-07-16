{ config, pkgs, ... }:

{

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
    extraPackages = with pkgs; [
      egl-wayland
      libva-utils
      vdpauinfo
      mangohud
    ];
    extraPackages32 = with pkgs; [
      pkgsi686Linux.mangohud
    ];
  };

  # Last Nvidia-driveren
  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
    # Påkrevd for Wayland/GNOME
    modesetting.enable = true;

    # Strømstyring for laptoper
    powerManagement.enable = true;
    #powerManagement.finegrained = true; # Bedre strømsparing på 50-serien
    dynamicBoost.enable = true;

    # Bruk den åpne drivermodulen (anbefalt for 5070 Ti)
    open = true;

    # Bruk stabil produksjonsdriver
    package = config.boot.kernelPackages.nvidiaPackages.stable;

    prime = {
      # offload = {
      #   enable = true;
      #   enableOffloadCmd = true;
      # };
      sync.enable = true;
      intelBusId = "PCI:0:2:0";
      nvidiaBusId = "PCI:2:0:0";
    };
  };
  environment.sessionVariables = {
    XKB_DEFAULT_LAYOUT = "no";
  };
  services.xserver.xkb = {
    layout = "no";
    variant = "";
  };
  console.keyMap = "no";

  # Fix for Intel Arrow Lake integrert grafikk
  boot.kernelParams = [ "i915.force_probe=7f2f" ];

  # --- SYSTEM VERSION ---
  system.stateVersion = "25.11";
}
