{ config, pkgs, ... }:

{
  # Tillat proprietær programvare (viktig for Nvidia og Steam)
  nixpkgs.config.allowUnfree = true;

  # Aktiver grafikkdrivere
  hardware.graphics = {
    enable = true;
    enable32Bit = true; # Viktig for Steam og eldre spill
  };

  # Nvidia-spesifikk konfigurasjon
  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
    # Modesetting er påkrevd for Wayland
    modesetting.enable = true;

    # Nvidia Power Management kan hjelpe på Legion-laptoper
    powerManagement.enable = true;
    powerManagement.finegrained = false;

    # Bruk den nyeste driveren (viktig for 50-serien!)
    package = config.boot.kernelPackages.nvidiaPackages.stable;

    # Open-source versjonen av driveren (anbefalt for nyere kort som 5070ti)
    open = true;

    # Aktiver Nvidia Settings-menyen
    nvidiaSettings = true;
  };
programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Åpne porter for Steam Remote Play
    dedicatedServer.openFirewall = true; # Åpne porter for Source Dedicated Server
    localNetworkGameTransfers.openFirewall = true; # Raskere installasjon mellom PC-er
  };

  # For å få bedre ytelse i spill (GameMode)
  programs.gamemode.enable = true;
hardware.nvidia.prime = {
    offload = {
      enable = true;
      enableOffloadCmd = true;
    };
    # Finn disse ID-ene ved å kjøre: lspci | grep -E "VGA|3D"
    intelBusId = "PCI:0:2:0";   # Eksempel, sjekk din egen
    nvidiaBusId = "PCI:1:0:0";  # Eksempel, sjekk din egen
  };
}
