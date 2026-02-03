{ config, lib, pkgs, inputs, ... }:

let
  cfg = config.my.mango;
in
{
  options.my.mango.enable = lib.mkEnableOption "mango-wc compositor";

  config = lib.mkIf cfg.enable {
    home-manager.users.vegard = {
      # Move the HM-specific module import here
      imports = [
        inputs.mango.hmModules.mango
      ];

      wayland.windowManager.mango = {
        enable = true;
        settings = ''
          # Gaps
          gappih=10
          gappiv=10
          
          # NVIDIA RTX 5070Ti Tweaks
          

          # Keybindings
          bind=SUPER,Return,spawn,foot
          bind=SUPER,q,killclient,
          bind=SUPER+SHIFT,e,quit,
          
          # Layouts
          bind=SUPER,s,setlayout,scroller
          bind=SUPER,t,setlayout,tile
        '';

        autostart_sh = ''
          waybar &
          # swaybg -m fill -i /path/to/wallpaper.jpg &
        '';
      };

      home.packages = with pkgs; [
        foot
        waybar
        swaybg
      ];
    };
  };
}
