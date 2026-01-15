#!/bin/sh
#
# Autostart on dwm
touch /tmp/dwm_autostart_ran

# Only run these commands if the session is DWM
    
  # 1. Set Wallpaper
  if [ -f $HOME/Pictures/wallpapers/wall1.jpg ]; then
     xwallpaper --zoom $HOME/Pictures/wallpapers/wall1.jpg
  fi

  # 2. Start Polkit
  if [ -f /run/current-system/sw/libexec/polkit-gnome-authentication-agent-1 ]; then
    /run/current-system/sw/libexec/polkit-gnome-authentication-agent-1 &
  fi  # 3. Start Compositor
      
  "$HOME/.config/nixos/desktop/dwm/scripts/statusbar" &
