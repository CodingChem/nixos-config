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
                    # Reload the configuration file
                    bind=SUPER+SHIFT,r,reload,
                    # Gaps
                    gappih=0
                    gappiv=0
          
                    # NVIDIA RTX 5070Ti Tweaks
                    env=LIBVA_DRIVER_NAME,nvidia
                    env=GBM_BACKEND,nvidia-drm
                    env=__GLX_VENDOR_LIBRARY_NAME,nvidia
                    env=WLR_NO_HARDWARE_CURSORS,1
          

                    # Keybindings
                    bind=SUPER,p,spawn,wofi --show run
                    bind=SUPER+SHIFT,n,spawn,obsidian
                    bind=SUPER+SHIFT,Return,spawn,kitty
                    bind=SUPER+SHIFT,b,spawn,chromium
                    bind=SUPER+SHIFT,a,spawn,chromium --app=https://gemini.google.com/app
                    bind=SUPER+SHIFT,w,spawn,chromium --app=https://web.whatsapp.com
                    bind=SUPER+SHIFT,m,spawn,chromium --app=https://messages.google.com/web/conversations
                    bind=SUPER+SHIFT,e,spawn,chromium --app=https://mail.google.com/mail/u/0/#inbox
                    bind=SUPER+SHIFT,c,spawn,chromium --app=https://calendar.google.com/calendar/u/0/r?pli=1
                    bind=SUPER+SHIFT,g,spawn,steam
                    bind=SUPER+SHIFT,s,spawn,spotify
                    # Focus
                    bind=SUPER,h,focusdir,left
                    bind=SUPER,l,focusdir,right
                    bind=SUPER,j,focusdir,down
                    bind=SUPER,k,focusdir,up
                    bind=SUPER,f,togglemaximizescreen
                    bind=SUPER+SHIFT,f,togglefullscreen
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
                    bind=SUPER+SHIFT,q,quit,
          
                    # Layouts
                    bind=SUPER,s,setlayout,scroller
                    bind=SUPER,t,setlayout,tile

                    # autostart
                    exec-once=waybar
                    exec-once=swaybg -m fill -i /home/vegard/Pictures/wall

                    # Switch to workspace/tag 1-9
          bind=SUPER,1,view,1,0
          bind=SUPER,2,view,2,0
          bind=SUPER,3,view,3,0
          bind=SUPER,4,view,4,0
          bind=SUPER,5,view,5,0
          bind=SUPER,6,view,6,0
          bind=SUPER,7,view,7,0
          bind=SUPER,8,view,8,0
          bind=SUPER,9,view,9,0

          # Move focused window to workspace 1-9
          bind=SUPER+SHIFT,1,tag,1,0
          bind=SUPER+SHIFT,2,tag,2,0
          bind=SUPER+SHIFT,3,tag,3,0
          bind=SUPER+SHIFT,4,tag,4,0
          bind=SUPER+SHIFT,5,tag,5,0
          bind=SUPER+SHIFT,6,tag,6,0
          bind=SUPER+SHIFT,7,tag,7,0
          bind=SUPER+SHIFT,8,tag,8,0
          bind=SUPER+SHIFT,9,tag,9,0

          bind=SUPER+CTRL,1,toggleview,1,0
          bind=SUPER+CTRL,2,toggleview,2,0
          bind=SUPER+CTRL,3,toggleview,3,0
          bind=SUPER+CTRL,4,toggleview,4,0
          bind=SUPER+CTRL,5,toggleview,5,0
          bind=SUPER+CTRL,6,toggleview,6,0
          bind=SUPER+CTRL,7,toggleview,7,0
          bind=SUPER+CTRL,8,toggleview,8,0
          bind=SUPER+CTRL,9,toggleview,9,0
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
