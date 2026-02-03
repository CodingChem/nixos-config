{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.my.hyprland;
in
{
  options.my.hyprland = {
    enable = mkEnableOption "Hyprland customization";
  };

  config = mkIf cfg.enable {
    # 1. Enable the Hyprland binary and cache
    programs.hyprland = {
      enable = true;
      xwayland.enable = true;
    };

    # 2. Nvidia specific environment variables
    environment.sessionVariables = {
      # Nvidia-specific Wayland fixes
      LIBVA_DRIVER_NAME = "nvidia";
      GBM_BACKEND = "nvidia-drm";
      __GLX_VENDOR_LIBRARY_NAME = "nvidia";
      
      # Electron / Wayland compatibility
      NIXOS_OZONE_WL = "1";
      
      # Tell apps this is Hyprland
      XDG_CURRENT_DESKTOP = "Hyprland";
      XDG_SESSION_DESKTOP = "Hyprland";
      XDG_SESSION_TYPE = "wayland";
    };

    # 3. Essential Packages for a Wayland Desktop
    environment.systemPackages = with pkgs; [
      waybar           # The status bar
      swww             # Wallpaper daemon
      kitty            # Terminal
      wofi             # App launcher
      dunst            # Notifications
      grim             # Screenshots
      slurp            # Region selection
      wl-clipboard     # Clipboard manager
      libva-utils      # For hardware acceleration checks
    ];

    # 4. Portals for Wayland
    xdg.portal = {
      enable = true;
      extraPortals = [ pkgs.xdg-desktop-portal-hyprland ];
      config.common.default = "hyprland";
    };

    # 5. Optional: Home-Manager Integration
    # You can move your specific Hyprland config (blur, keybinds) into here
    home-manager.users.vegard = { ... }: {
      wayland.windowManager.hyprland = {
        enable = true;
        settings = {
          # Use your 240Hz monitor to its full potential
	  input.kb_layout = "no";
          monitor = [
            "eDP-1, 2560x1600@240, 0x0, 1"
          ];
	  "$mod" = "SUPER";
	  bind = [
	    "$mod, P, exec, wofi --drun"
	    "$mod, Return, exec, kitty"
	  ];
          
          # Nvidia Performance Tweaks
          cursor = {
            no_hardware_cursors = true; # Often needed on Nvidia to see the cursor
          };

          general = {
            gaps_in = 5;
            gaps_out = 10;
            border_size = 2;
          };

          decoration = {
            blur = {
              enabled = true;
              size = 5;
              passes = 3;
              new_optimizations = true;
            };
          };
        };
      };
    };
  };
}
