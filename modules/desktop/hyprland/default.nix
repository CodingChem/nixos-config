{ config, pkgs, inputs, lib, ...}:
with lib;

let
  cfg = config.myDesktop;
in
{
  config = mkIf (cfg.enable && cfg.environment == "hyprland") {
    services.displayManager.ly.enable = true;
    programs.hyprland = {
      enable = true;
      withUWSM = true;
      xwayland.enable = true;
      package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
      portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
    };
    environment.systemPackages = with pkgs; [
      rofi
      swaybg
      hyprpolkitagent
      quickshell
    ];
    xdg.portal = {
      enable = true;
      extraPortals = [
        pkgs.xdg-desktop-portal-gtk
      ];
      config.common.default = [ "gtk" ];
      config.hyprland.default = [ "hyprland" "gtk" ];
    };
  };
}
