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
      '';
    };
  };
  services.displayManager.ly.enable = true;
  
  environment.systemPackages = with pkgs; [
    alacritty
    xclip
    xwallpaper
  ];
}
