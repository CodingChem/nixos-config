{ config, pkgs, lib, ... }:

{
  # Enable CUPS to print documents.
  services.printing.enable = true;
  # Flatpak
  services.flatpak.enable = true;

  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-wlr
    ];
    config.common.default = "wlr";
  };

  environment.systemPackages = with pkgs; [
    chromium
    spotify
    distrobox
    android-tools
    (wrapOBS {
      plugins = with obs-vkcapture; [
        obs-vkcapture # Better performance for recording games
      ];
    })
  ];
  programs = {
    chromium = {
      enable = true;
      # package = pkgs.chromium;
      extensions = [
        "ddkjiahejlhfcafbddmgiahcphecmpfh"
        "nngceckbapebfimnlniiiahkandclblb"
      ];
    };
  };
}
