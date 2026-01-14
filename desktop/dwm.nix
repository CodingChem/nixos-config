{pkgs, ... }:

{
  services.xserver = {
    enable = true;
    autoRepeatDelay = 200;
    autoRepeatInterval = 35;
    windowManager.dwm = {
      enable = true;
      package = pkgs.dwm.overrideAttrs {
        src = ./../src/dwm;
      };
    };
    displayManager = {
      sessionCommands = ''
      xwallpaper --zoom ~/Pictures/wallpapers/wall1.jpg
      ${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1 &
      '';
    };
  };
  services.displayManager.ly.enable = true;
  
  environment.systemPackages = with pkgs; [
    alacritty
    xclip
    xwallpaper
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

  # 3. Ensure GSettings schemas are available (Fixes crashing GTK apps)
  environment.systemPackages = [
    pkgs.gsettings-desktop-schemas
    pkgs.glib # Contains gsettings tool
    pkgs.gtk3
    pkgs.polkit_gnome
  ];
}
