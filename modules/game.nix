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


  # Spill-relaterte verktøy
  programs.gamemode.enable = true;
  programs.gamescope.enable = true;

  environment.systemPackages = with pkgs; [
    mangohud             # FPS/Overlay
    nvtopPackages.nvidia # GPU Monitor (veldig kjekk!)
    vulkan-tools         # For å teste med 'vulkaninfo'
  ];
}
