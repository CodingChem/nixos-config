{ config, pkgs, lib, ... }:

{

  programs.niri = {
    enable = true;
    };
  home.packages = with pkgs; [
    xwayland-satellite
  ];

    # settings = {
    #   # Input device configuration
    #   input = {
    #     keyboard.xkb.layout = "us";
    #     touchpad = {
    #       tap = true;
    #       natural-scroll = true;
    #     };
    #   };
    #   };
    #   };
  #
  #     # Layout settings
  #     layout = {
  #       gaps = 16;
  #       center-focused-column = "never";
  #
  #       preset-column-widths = [
  #         { proportion = 0.33333; }
  #         { proportion = 0.5; }
  #         { proportion = 0.66667; }
  #       ];
  #
  #       default-column-width = { proportion = 0.5; };
  #
  #       focus-ring = {
  #         enable = true;
  #         width = 4;
  #         active-color = "#7fc8ff";
  #         inactive-color = "#505050";
  #       };
  #     };
  #
  #     # Keybindings
  #     binds = with config.lib.niri.actions; {
  #       # Mod key is usually Super/Windows
  #       "Mod+Shift+E".action = quit;
  #       "Mod+Q".action = close-window;
  #
  #       # Application launchers
  #       # "spawn" expects a list of strings: ["command" "arg"]
  #       "Mod+Return".action = spawn "ghostty"; 
  #       "Mod+D".action = spawn "fuzzel"; 
  #
  #       # Window movement (Vim keys)
  #       "Mod+H".action = focus-column-left;
  #       "Mod+L".action = focus-column-right;
  #       "Mod+J".action = focus-window-down;
  #       "Mod+K".action = focus-window-up;
  #
  #       "Mod+Ctrl+H".action = move-column-left;
  #       "Mod+Ctrl+L".action = move-column-right;
  #
  #       # Scrollable Tiling logic (Home/End)
  #       "Mod+Home".action = focus-column-first;
  #       "Mod+End".action = focus-column-last;
  #
  #       # Screenshots
  #       "Print".action = screenshot;
  #       "Ctrl+Print".action = screenshot-screen;
  #       "Alt+Print".action = screenshot-window;
  #     };
  #
  #     # Startup commands
  #     spawn-at-startup = [
  #       { command = [ "waybar" ]; }
  #
  #       # Xwayland-satellite is required for X11 apps on Niri
  #       # (Niri does not provide its own Xwayland server)
  #       { command = [ "xwayland-satellite" ]; } 
  #     ];
  #   };
  # };
  #
  # # Configure Fuzzel
  # # programs.fuzzel = {
  # #   enable = true;
  # #   settings = {
  # #     main = {
  # #       # Updated to use Ghostty to match your preference
  # #       terminal = "${pkgs.ghostty}/bin/ghostty"; 
  # #       layer = "overlay";
  # #     };
  # #     colors = {
  # #       background = "282a36dd";
  # #       text = "f8f8f2ff";
  # #       selection = "44475add";
  # #       selection-text = "f8f8f2ff";
  # #       border = "bd93f9ff";
  # #     };
  # #   };
  # # };
}
