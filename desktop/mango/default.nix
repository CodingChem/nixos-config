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
          env=LIBVA_DRIVER_NAME,nvidia
          env=GBM_BACKEND,nvidia-drm
          env=__GLX_VENDOR_LIBRARY_NAME,nvidia
          env=WLR_NO_HARDWARE_CURSORS,1
          

          # Keybindings
          bind=SUPER,Return,spawn,kitty
          bind=SUPER,q,killclient,
          bind=SUPER+SHIFT,e,quit,
          
          # Layouts
          bind=SUPER,s,setlayout,scroller
          bind=SUPER,t,setlayout,tile

          # autostart
          exec-once=waybar
          exec-once=swaybg -m fill -i /home/vegard/Pictures/wall
        '';
      };

      home.packages = with pkgs; [
        kitty
        waybar
        swaybg
        wofi
      ];
    };
  };
}
