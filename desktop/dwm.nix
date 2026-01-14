{pkgs, ... }:

{
  services.xserver = {
    enable = true;
    autoRepeatDelay = 200;
    autoRepeatInterval = 35;
    windowManager.dwm = {
      enable = true;
      package = pkgs.dwm.overrideAttrs {
        # src = ./../src/dwm;
      };
    };
  };

  services.xserver.displayManager.lightdm = {
    enable = true;
    greeters.slick.enable = true;
  };
  # services.xserver.displayManager.sessionCommands = ''
  #     # Set Wallpaper
  #     # Check if file exists to avoid error if path is wrong
  #     if [ -f $HOME/Pictures/wallpapers/wall1.jpg ]; then
  #       ${pkgs.xwallpaper}/bin/xwallpaper --zoom $HOME/Pictures/wallpapers/wall1.jpg
  #     fi
  #
  #     # Start Polkit (Critical for password prompts)
  #     ${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1 &
  #
  #     # Start Compositor (Transparency/Vsync)
  #     ${pkgs.picom}/bin/picom &
  #   '';

  environment.systemPackages = with pkgs; [
    alacritty
    xclip
    xwallpaper
    gsettings-desktop-schemas
    glib
    gtk3
    polkit_gnome
    picom
  ];
  environment.sessionVariables = {
    # Hints for apps to know how to draw themselves
    XDG_CURRENT_DESKTOP = "dwm"; 
    XDG_SESSION_DESKTOP = "dwm";
    XDG_SESSION_TYPE = "x11";
    
    # Fix for Java apps (if you use them) behaving weirdly in tiling WMs
    _JAVA_AWT_WM_NONREPARENTING = "1";
    
    # Optional: Force GTK apps to use a specific theme if they ignore system settings
    GTK_THEME = "Adwaita:dark";
  };

  # 2. XDG Portals (Crucial for "Open File" dialogs and screen sharing)
  xdg.portal = {
    enable = true;
    extraPortals = [ 
      pkgs.xdg-desktop-portal-gtk # Use GTK file picker even in dwm
    ];
    config.common.default = "*";
  };
}
