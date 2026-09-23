{ config, lib, pkgs, ... }:
let
  cfg = config.mygnome;
in
{
  options.mygnome = {
    enable = lib.mkEnableOption "Enable gnome desktop environment";
  };
  config = lib.mkIf cfg.enable {
  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;
  environment.systemPackages = with pkgs; [
    gnome-tweaks
  ];
  };
}
