{ config, pkgs, lib, ... }:

{
  programs.niri = {
    enable = true;

    # The configuration below translates to Niri's config.kdl
    settings = {
      # Input device configuration
      input = {
        keyboard.xkb.layout = "us";
        touchpad = {
          tap = true;
          natural-scroll = true;
        };
      };

      # Output (Monitor) configuration
      # Niri usually auto-detects, but you can pin settings here.
      # output."DP-1" = {
      #   mode = "2560x1440@144";
      #   scale = 1.0;
      # };

      # Layout settings
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

      # Keybindings
      binds = with config.lib.niri.actions; let
        sh = spawn: spawn "sh" "-c" spawn;
      in {
        # Mod key is usually Super/Windows
        "Mod+Shift+E".action = quit;
        "Mod+Q".action = close-window;

        # Application launchers
        "Mod+Return".action = spawn-sh "ghostty";
        "Mod+D".action = spawn "fuzzel"; # Menu/Launcher

        # Window movement (Vim keys)
        "Mod+H".action = focus-column-left;
        "Mod+L".action = focus-column-right;
        "Mod+J".action = focus-window-down;
        "Mod+K".action = focus-window-up;

        "Mod+Ctrl+H".action = move-column-left;
        "Mod+Ctrl+L".action = move-column-right;
        
        # Scrollable Tiling logic (Home/End)
        "Mod+Home".action = focus-column-first;
        "Mod+End".action = focus-column-last;

        # Screenshots
        "Print".action = screenshot;
        "Ctrl+Print".action = screenshot-screen;
        "Alt+Print".action = screenshot-window;
      };

      # Startup commands
      spawn-at-startup = [
        { command = [ "waybar" ]; }
        { command = [ "xwayland-satellite" ]; } # If you need X11 apps
      ];
    };
  };
  
  # Optional: Style Fuzzel to look nice immediately
  programs.fuzzel = {
    enable = true;
    settings = {
      main = {
        terminal = "${pkgs.alacritty}/bin/alacritty";
        layer = "overlay";
      };
      colors = {
        background = "282a36dd";
        text = "f8f8f2ff";
        selection = "44475add";
        selection-text = "f8f8f2ff";
        border = "bd93f9ff";
      };
    };
  };
}
