{ config, pkgs, ... }:

{
  # 1. Enable Niri System Session (Login Screen)
  programs.niri.enable = true;

  # 2. Configure User Settings
  home-manager.users.vegard = { config, pkgs, ... }: {
    
    # Packages to install
    home.packages = with pkgs; [
      xwayland-satellite
      waybar
    ];

    programs.niri = {
      enable = true;
      package = pkgs.niri; # Use standard Nixpkgs version

      settings = {
        input = {
          keyboard.xkb.layout = "us";
          touchpad = {
            tap = true;
            natural-scroll = true;
          };
        };

        layout = {
          gaps = 16;
          center-focused-column = "never";
          preset-column-widths = [
            { proportion = 0.33333; }
            { proportion = 0.5; }
            { proportion = 0.66667; }
          ];
          default-column-width = { proportion = 0.5; };
          focus-ring = {
            enable = true;
            width = 4;
            active-color = "#7fc8ff";
            inactive-color = "#505050";
          };
        };

        # --- KEYBINDINGS (Standard Format) ---
        binds = {
          "Mod+Shift+E".action.quit = {};
          "Mod+Q".action.close-window = {};
          
          # Spawning apps
          "Mod+Return".action.spawn = "ghostty";
          "Mod+D".action.spawn = "fuzzel";

          # Navigation
          "Mod+H".action.focus-column-left = {};
          "Mod+L".action.focus-column-right = {};
          "Mod+J".action.focus-window-down = {};
          "Mod+K".action.focus-window-up = {};
          
          "Mod+Ctrl+H".action.move-column-left = {};
          "Mod+Ctrl+L".action.move-column-right = {};
          
          "Mod+Home".action.focus-column-first = {};
          "Mod+End".action.focus-column-last = {};

          # Screenshots
          "Print".action.screenshot = {};
          "Ctrl+Print".action.screenshot-screen = {};
          "Alt+Print".action.screenshot-window = {};
        };

        # --- Startup ---
        spawn-at-startup = [
          { command = [ "xwayland-satellite" ]; }
          { command = [ "waybar" ]; }
        ];
      };
    };
  };
}
