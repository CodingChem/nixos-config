{ config, pkgs, inputs, lib, ...}:

with lib;

let cfg = config.myhyprland;

in
{
  options.myhyprland = {
    enable = mkEnableOption "Enable Hyprland.";
  };
  config = mkIf cfg.enable {
    users.users.vegard.packages = with pkgs; [
      rofi
        swaybg
    ];
    services.displayManager.ly.enable = true;
    programs.hyprland = {
      enable = true;
      xwayland.enable = true;
      package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
      portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
    };
  };
}
