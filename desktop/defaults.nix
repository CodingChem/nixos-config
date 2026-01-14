{ config, pkgs, lib, ... }:

{
  # Enable CUPS to print documents.
  services.printing.enable = true;
  # Flatpak
  # services.flatpak.enable = true;

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
	     commandLineArgs  = [
	       "--enable-features=WebUIDarkMode"
	       "--force-dark-mode"
	#        "--ozone-platform-hint=auto"
	# "--enable-features=WaylandWindowDecorations"
	     ];
    };
  };
}
