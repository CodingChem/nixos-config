{
  pkgs,
  config,
  ...
}:
{
  programs.fuse.enable = true;
  environment.systemPackages = with pkgs; [
    dmenu
    kitty
    xclip
  ];
  services.displayManager.ly.enable = true;
  services.xserver.windowManager.oxwm.enable = true;
  services.xserver.enable = true;
  services.xserver.updateDbusEnvironment = true;
  services.dbus.enable = true;
  xdg.portal  = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    config.common.default = "*";
  };
  services.picom = {
    enable = true;
    fade = true;
    shadow = true;
  };
}
