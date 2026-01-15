{ pkgs, ... }:

{
  nixpkgs.overlays = [
    (final: prev: {
      dmenu = prev.dmenu.overrideAttrs (oldAttrs: {

        # This copies your local config.h into the source folder before compiling
        postPatch = (oldAttrs.postPatch or "") + ''
          cp ${./dmenu.def.h} config.def.h
        '';
      });


      dwm = prev.dwm.overrideAttrs (oldAttrs: {

        # This copies your local config.h into the source folder before compiling
        postPatch = (oldAttrs.postPatch or "") + ''
          cp ${./config.def.h} config.def.h
        '';
      });
    })
  ];

  services.xserver = {
    enable = true;
    autoRepeatDelay = 200;
    autoRepeatInterval = 35;
    windowManager.dwm = {
      enable = true;
    };
  };

  services.displayManager.ly = {
    enable = true;
  };
  services.xserver.displayManager.sessionCommands = ''
    /home/vegard/.config/nixos/desktop/dwm/scripts/autostart.sh > /tmp/autostart.log 2>&1 &  '';

  environment.systemPackages = with pkgs; [
    alacritty
    xclip
    xwallpaper
    gsettings-desktop-schemas
    glib
    gtk3
    polkit_gnome
    picom
    dmenu
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
  home-manager.users.vegard = { pkgs, ... }: {
    home.packages = with pkgs; [
      slock
      brightnessctl
    ];

    services.picom = {
      enable = true;

      # 1. Backend & Performance (Optimized for Nvidia)
      backend = "glx";
      vSync = true; # Prevents screen tearing

      # 2. Shadows
      shadow = true;
      shadowOpacity = 0.75;
      shadowExclude = [
        "name = 'Notification'"
        "class_g = 'Conky'"
        "class_g ?= 'Notify-osd'"
        "class_g = 'Cairo-clock'"
        "_GTK_FRAME_EXTENTS@:c"
      ];

      # 3. Fading (Makes window opening/closing smoother)
      fade = true;
      fadeDelta = 10;

      # 4. Opacity / Transparency
      activeOpacity = 1.0;
      inactiveOpacity = 0.95; # Dim inactive windows slightly

      # 5. Specific Window Rules
      opacityRules = [
        "100:class_g = 'Firefox'" # Keep browser opaque
        "100:class_g = 'mpv'" # Keep video player opaque
        "90:class_g = 'Alacritty'" # Transparent terminal (if you use Alacritty)
        "90:class_g = 'St'" # Transparent terminal (if you use st)
      ];

      # 6. Extra Config (For Nvidia specific tweaks)
      settings = {
        blur = {
          method = "dual_kawase"; # The best looking blur, needs 'glx'
          strength = 5;
        };
        # Fixes for Nvidia generic flickering
        unredir-if-possible = false;
      };
    };
  };
}

