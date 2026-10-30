{ config, lib, pkgs, ... }:
let
  cfg = config.myDesktop;
in
{
  config = lib.mkIf (cfg.enable && cfg.environment == "gnome") {
    # Enable the X11 windowing system.
    services.xserver.enable = true;

    # Enable the GNOME Desktop Environment.
    services.displayManager.gdm.enable = true;
    services.desktopManager.gnome.enable = true;
    environment.systemPackages = [
      pkgs.gnome-tweaks
    ];
  };
}
