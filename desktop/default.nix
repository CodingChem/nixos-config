{ config, lib, ... }:

{
  imports = [
    ./dwm/dwm.nix
    ./hyprland.nix
    ./shared.nix
  ];

  options.my.desktop.type = lib.mkOption {
    type = lib.types.enum [ "dwm" "hyprland" ];
    default = "dwm";
  };

  config = lib.mkMerge [
    (lib.mkIf (config.my.desktop.type == "dwm") {
      my.dwm.enable = true;
    })
    (lib.mkIf (config.my.desktop.type == "hyprland") {
      my.hyprland.enable = true;
    })
  ];
}
