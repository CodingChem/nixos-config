{ config, pkgs, lib, ... }:

{
  # Enable CUPS to print documents.
  services.printing.enable = true;

  environment.systemPackages = with pkgs; [
    chromium
  ];
  programs = {
    chromium = {
      enable = true;
      # package = pkgs.chromium;
      extensions = [
        "ddkjiahejlhfcafbddmgiahcphecmpfh"
	"nngceckbapebfimnlniiiahkandclblb"
      ];
	#      commandLineArgs  = [
	#        "--ozone-platform-hint=auto"
	# "--enable-features=WaylandWindowDecorations"
	#      ];
    };
  };
}
