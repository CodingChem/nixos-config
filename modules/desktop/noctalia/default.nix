{ lib, config, inputs, ... }:
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

    home-manager.users.drfoobar = {
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
