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
      ly.enable = true;
      sessionCommands = ''
      # 1. set backgroundcolor
      ${pkgs.xorg.xsetroot}/bin/xsetroot -solid "#24273a"
      # 2. wallpaper loop
      sh -c '
        while true; do
	  # random file
	  if [ -d "$HOME/Pictures/wallpapers" ]; then
             ${pkgs.findutils}/bin/find "$HOME/Pictures/wallpapers" -type f \
             | ${pkgs.coreutils}/bin/shuf -n 1 \
             | ${pkgs.findutils}/bin/xargs ${pkgs.xwallpaper}/bin/xwallpaper --zoom
          fi
          sleep 1m
	done
      ' &
      '';
    };
  };
  
  environment.systemPackages = with pkgs; [
    alacritty
    xclip
    xwallpaper
  ];
}
