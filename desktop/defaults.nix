{ config, pkgs, lib, ... }:

{
  # Enable CUPS to print documents.
  services.printing.enable = true;
  # Flatpak
  services.flatpak.enable = true;

  environment.systemPackages = with pkgs; [
    chromium
    spotify
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
