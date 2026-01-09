{ config, pkgs, ... }:

{
  # Tillat Steam og Nvidia-drivere (Unfree)
  nixpkgs.config.allowUnfree = true;

  # Aktiver Steam
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
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

  # Spill-relaterte verktøy
  programs.gamemode.enable = true;

  environment.systemPackages = with pkgs; [
    mangohud             # FPS/Overlay
    nvtopPackages.nvidia # GPU Monitor (veldig kjekk!)
    vulkan-tools         # For å teste med 'vulkaninfo'
  ];
}
