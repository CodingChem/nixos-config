{pkgs, ... }:

{
  services.xserver = {
    enable = true;
    autoRepeatDelay = 200;
    autoRepeatInterval = 35;
    windowManager.dwm = {
      enable = true;
      package = pkgs.dwm.overrideAttrs {
        src = ./dwm;
      };
    };
  };
  services.displayManager.ly.enable = true;
  environment.systemPackages = with pkgs; [
    kitty
    dmenu
    st
  ];
}
