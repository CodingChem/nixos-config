{ config, pkgs, lib, ... }:

{
  services.desktopManager.cosmic.enable = true;
  services.displayManager.cosmic-greeter.enable = true;
  services.xserver.xkb = {
    layout = "no";
    variant = "";
  };

  # Optional: Exclude default COSMIC packages if you prefer alternatives.
  # Unlike GNOME, COSMIC apps (Term, Edit, Files) are tightly integrated, 
  # so I recommend keeping them initially.
  # environment.cosmic.excludePackages = [ ];

  # --- Home Manager Configuration ---
  home-manager.users.vegard = { pkgs, ... }: {
    
    home.sessionVariables = {
      NIXOS_OZONE_WL = "1"; 
    };
  };
}
