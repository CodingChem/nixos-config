{ config, pkgs, inputs, ... }: # <--- Add 'inputs' here

{
  # 1. Import the Niri System Module (from the flake input)
  imports = [ inputs.niri.nixosModules.niri ];

  # 2. Enable the Niri login session
  programs.niri.enable = true;

  # 3. Configure the User (Home Manager)
  home-manager.users.vegard = { config, pkgs, ... }: {
    
    # 4. Import the Niri Home Manager Module (from the flake input)
    imports = [ inputs.niri.homeModules.niri ];

    home.packages = with pkgs; [
      xwayland-satellite
    ];

    programs.niri = {
      enable = true;
      package = pkgs.niri; # Use the binary from nixpkgs

      settings = {
        # --- Input ---
        input = {
          keyboard.xkb.layout = "us";
          touchpad = {
            tap = true;
            natural-scroll = true;
          };
        };

        # --- Layout ---
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

        # --- Keybindings ---
        binds = with config.lib.niri.actions; {
          "Mod+Shift+E".action = quit;
          "Mod+Q".action = close-window;
          "Mod+Return".action = spawn "ghostty"; 
          "Mod+D".action = spawn "fuzzel"; 
          
          "Mod+H".action = focus-column-left;
          "Mod+L".action = focus-column-right;
          "Mod+J".action = focus-window-down;
          "Mod+K".action = focus-window-up;
          "Mod+Ctrl+H".action = move-column-left;
          "Mod+Ctrl+L".action = move-column-right;
          "Mod+Home".action = focus-column-first;
          "Mod+End".action = focus-column-last;
          
          "Print".action = screenshot;
          "Ctrl+Print".action = screenshot-screen;
          "Alt+Print".action = screenshot-window;
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
