{ pkgs, ... }:

{
  programs.kitty = {
    enable = true;
    # Kitty handles Wayland/X11 automatically
    font = {
      name = "JetBrainsMono Nerd Font";
      size = 18;
    };
    settings = {
      scrollback_lines = 10000;
      enable_audio_bell = false;
      update_check_interval = 0; # Nix handles updates, so turn this off
      
      # Transparency (Optional - looks great on GNOME)
      background_opacity = "0.90";
    };
    
    # This makes Kitty play nice with certain window managers
    shellIntegration.enableZshIntegration = true; 
  };
}
