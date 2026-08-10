{
  pkgs,
  config,
  lib,
  ...
}:
with lib;

let cfg = config.myoxwm;

in
{
  options.myoxwm = {
    enable = mkEnableOption "Enable OXWM.";
  };

  config = mkIf cfg.enable {
    programs.fuse.enable = true;
    environment.systemPackages = with pkgs; [
      dmenu
        kitty
        xclip
    ];
    services.xserver.displayManager.lightdm.enable = true;
    services.xserver.windowManager.oxwm.enable = true;
    services.xserver.enable = true;
    services.xserver.updateDbusEnvironment = true;
    services.dbus.enable = true;
    xdg.portal  = {
      enable = true;
      extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
      config.common.default = "*";
    };
    xdg.configFile."oxwm/config.lua".source = ./config.lua
    services.picom = {
      enable = true;
      fade = true;
      shadow = true;
    };
  };
}
