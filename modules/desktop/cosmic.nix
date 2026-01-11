{ config, pkgs, lib, ... }:

{
  services.desktopManager.cosmic.enable = true;
  services.displayManager.cosmic-greeter.enable = true;
  services.xserver.xkb = {
    layout = "no";
    variant = "";
  };
  services.xserver.videoDrivers = [ "nvidia" ]; 
  
  hardware.graphics = {
    enable = true;
    # If on unstable/newer nixpkgs, 'enable32Bit' might be required for Steam/Games
    enable32Bit = true; 
  };

  # Optional: Exclude default COSMIC packages if you prefer alternatives.
  # Unlike GNOME, COSMIC apps (Term, Edit, Files) are tightly integrated, 
  # so I recommend keeping them initially.
  # environment.cosmic.excludePackages = [ ];

  # --- Home Manager Configuration ---
  home-manager.users.vegard = { pkgs, ... }: {
    
    # COSMIC doesn't use dconf (GSettings) for its own configuration.
    # It uses TOML files in ~/.config/cosmic.
    # However, we still want to configure GTK for non-COSMIC apps (Firefox, etc.)
    # so they look consistent with the desktop.

    # Install useful COSMIC utilities if they aren't pulled in by the desktop manager
    home.packages = with pkgs; [
      cosmic-ext-applet-clipboard-manager # Clipboard manager is essential
      cosmic-ext-applet-emoji-selector    # If you use emojis
      # cosmic-player                     # Music player (optional)
    ];

    # Session Variables for Wayland + Nvidia
    home.sessionVariables = {
      # Forces Chrome/Electron apps to use Wayland (smoother on your 5070Ti)
      NIXOS_OZONE_WL = "1"; 
    };
  };
}
