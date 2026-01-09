{ config, pkgs, ... }:

{
  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "no";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Install firefox.
  programs.firefox.enable = true;
  environment.gnome.excludePackages = (with pkgs; [
    gnome-tour
    gnome-maps
    gnome-weather
    geary
  ]);
}
