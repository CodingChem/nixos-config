{ config, lib, pkgs, ... }:

let
  cfg = config.my.mango;
in
{
  options.my.mango.enable = lib.mkEnableOption "mango-wc compositor";

  config = lib.mkIf cfg.enable {
    # Install the package
    home.packages = [ pkgs.mango-wc ];

    # Example Home Manager configuration for mango-wc
    # Adjust according to the specific attributes mango-wc supports in HM
    wayland.windowManager.mango-wc = {
      enable = true;
      # Add your specific config here
      # settings = { ... };
    };
  };
}
  # We add 'inputs' to the arguments list here
  { config, lib, pkgs, inputs, ... }:

  let
    cfg = config.my.mango;
  in
  {
    imports = [
      # This reaches back to flake.nix, finds the mango input, 
      # and loads its Home Manager module.
      inputs.mango.hmModules.mango
    ];

    options.my.mango.enable = lib.mkEnableOption "mango-wc compositor";

    config = lib.mkIf cfg.enable {
      wayland.windowManager.mango = {
        enable = true;
        settings = ''
          # Gaps
          gappih=10
          gappiv=10
        
          # NVIDIA Fixes for your 5070Ti
          env=LIBVA_DRIVER_NAME,nvidia
          env=GBM_BACKEND,nvidia-drm
          env=__GLX_VENDOR_LIBRARY_NAME,nvidia
          env=WLR_NO_HARDWARE_CURSORS,1

          # Keybindings
          bind=SUPER,Return,spawn,foot
          bind=SUPER,q,killclient,
          bind=SUPER_SHIFT,e,exit,
        
          # Layouts
          bind=SUPER,s,setlayout,scroller
          bind=SUPER,t,setlayout,tile
        '';

        autostart_sh = ''
          waybar &
          swaybg -m fill -i /path/to/wallpaper.jpg &
        '';
      };

      home.packages = with pkgs; [
        foot
        waybar
        swaybg
      ];
    };
  }
