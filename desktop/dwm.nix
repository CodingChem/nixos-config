{pkgs, ... }:

let
  dwmSession = pkgs.writeShellScriptBin "dwm-session" ''
    # Set background (Use full path to binary for safety)
    ${pkgs.xwallpaper}/bin/xwallpaper --zoom $HOME/Pictures/wallpapers/wall1.jpg &

    # Start Polkit (Password prompts)
    ${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1 &
    
    # Start Picom (Compositor - fixes tearing)
    ${pkgs.picom}/bin/picom &

    # Finally, start DWM (exec is important!)
    exec ${pkgs.dwm}/bin/dwm  '';

dwmSession = pkgs.runCommand "dwm-session" {
    # This tells NixOS exactly what the session is named (Fixes the error!)
    passthru.providedSessions = [ "dwm-session" ];
  } ''
    # Create the binary directory and link our script
    mkdir -p $out/bin
    ln -s ${dwmScript}/bin/dwm-session $out/bin/dwm-session

    # Create the xsessions directory and the .desktop file
    mkdir -p $out/share/xsessions
    cat > $out/share/xsessions/dwm-session.desktop <<EOF
    [Desktop Entry]
    Name=DWM Custom
    Comment=Custom DWM Session
    Exec=$out/bin/dwm-session
    Type=Application
    EOF
  '';
in

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
  };
  services.displayManager.ly.enable = true;
  services.displayManager.sessionPackages = [ dwmSession ];
  
  environment.systemPackages = with pkgs; [
    alacritty
    xclip
    xwallpaper
    gsettings-desktop-schemas
    glib
    gtk3
    polkit_gnome
    picom
    dwmSession
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
