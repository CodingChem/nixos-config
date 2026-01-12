{ config, pkgs, ... }:

{
  programs.dms-shell = {
    enable = true;
    
    # Optional: Enable the Dank Greeter (Login Screen)
    # This replaces GDM/SDDM with the DMS-styled greeter
    # services.displayManager.dms-greeter.enable = true;
  };

  # DMS works best with Niri, but supports Hyprland/Sway
  programs.niri.enable = true; 
}

