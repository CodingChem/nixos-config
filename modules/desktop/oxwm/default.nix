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
        feh
    ];
    services.xserver.displayManager.lightdm.enable = true;
    services.xserver.windowManager.oxwm.enable = true;
    services.xserver.enable = true;
    services.xserver.updateDbusEnvironment = true;
    services.dbus.enable = true;
    xdg.portal  = {
      enable = true;
      extraPortals = [ 
        pkgs.xdg-desktop-portal-termfilechooser
      ];
      config.common.default = "*";
    };
    services.picom = {
      enable = true;
      fade = true;
      shadow = true;
    };
    home-manager.users.vegard = {
      xdg.configFile."oxwm/config.lua".text = ''
      -- dummy importer file to allow config modification
      -- replace path
      path = "/home/vegard/Repos/nixos-system/modules/desktop/oxwm/config.lua"
      dofile(path)
      '';
    };
  };
}
