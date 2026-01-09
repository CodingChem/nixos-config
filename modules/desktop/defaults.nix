{ config, pkgs, lib, ... }:

{
  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Install firefox.
  programs = {
    chromium = {
      enable = true;
      # package = pkgs.chromium;
      extensions = [
        { id = "ddkjiahejlhfcafbddmgiahcphecmpfh"; }
	{ id = "nngceckbapebfimnlniiiahkandclblb"; }
      ];
	#      commandLineArgs  = [
	#        "--ozone-platform-hint=auto"
	# "--enable-features=WaylandWindowDecorations"
	#      ];
    };
  };
}
