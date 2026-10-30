{ config, lib, pkgs, ... }:
with lib;

let
  cfg = config.mySystem.gaming;
in
{
  options.mySystem.gaming = {
    enable = mkEnableOption "Enable gaming tools and optimizations (Steam, Gamemode, Gamescope)";
  };

  config = mkIf cfg.enable {
    nixpkgs.config.allowUnfree = true;

    programs.steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
      localNetworkGameTransfers.openFirewall = true;
    };

    programs.gamemode.enable = true;
    programs.gamescope.enable = true;
  };
}
