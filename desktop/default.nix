{ config, lib, ... }:

{
  imports = [
    ./dwm/dwm.nix
    ./hyprland.nix
    ./shared.nix
    ./mango
  ];

  options.my.desktop.type = lib.mkOption {
    type = lib.types.enum [ "dwm" "hyprland" "mango" ];
    default = "dwm";
  };

  config = lib.mkMerge [
    (lib.mkIf (config.my.desktop.type == "dwm") {
      my.dwm.enable = true;
    })
    (lib.mkIf (config.my.desktop.type == "hyprland") {
      my.hyprland.enable = true;
    })
    (lib.mkIf (config.my.desktop.type == "mango")
      {
        my.mango.enable = true;
      })
  ];
}
