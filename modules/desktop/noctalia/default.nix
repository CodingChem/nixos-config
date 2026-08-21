{ lib, config, inputs, pkgs, ... }:
with lib;
let cfg = config.mynoctalia;
in
{
  options.mynoctalia = {
    enable = mkEnableOption "Enable Noctalia.";
  };
  config = mkIf cfg.enable {
    networking.networkmanager.enable = true;
    hardware.bluetooth.enable = true;
    services.power-profiles-daemon.enable = true;
    services.upower.enable = true;

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
    environment.systemPackages = with pkgs; [
      hyprpolkitagent
    ];

    home-manager.users.vegard = {
      imports = [
        inputs.noctalia.homeModules.default
      ];

      programs.noctalia = {
        enable = true;

        settings = { # This may also be a string or path to a .toml file.
          theme = {
            mode = "dark";
            source = "builtin";
            builtin = "Catppuccin";
          };

          wallpaper = {
            enabled = true;
            default.path = "~/Pictures/walls/wall.jpg";
          };
        };
      };
    };
  };
}
