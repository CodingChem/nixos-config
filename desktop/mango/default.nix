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
          bind=SUPER,p,spawn,wofi --show drun
          # Focus
          bind=SUPER,h,focusdir,left
          bind=SUPER,l,focusdir,right
          bind=SUPER,j,focusdir,down
          bind=SUPER,k,focusdir,up
          # Swap
          bind=SUPER+SHIFT,k,exchange_client,up
          bind=SUPER+SHIFT,j,exchange_client,down
          bind=SUPER+SHIFT,h,exchange_client,left
          bind=SUPER+SHIFT,l,exchange_client,right
          # resize
          bind=SUPER+CTRL,h,resizewin,-50,+0
          bind=SUPER+CTRL,l,resizewin,+50,+0
          bind=SUPER+CTRL,j,resizewin,+0,+50
          bind=SUPER+CTRL,k,resizewin,+0,-50
          # move
          bind=SUPER+ALT,l,movewin,+50,+0
          bind=SUPER+ALT,h,movewin,-50,+0
          bind=SUPER+ALT,j,movewin,+0,+50
          bind=SUPER+ALT,k,movewin,+0,-50

          
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
