{ config, pkgs, ... }:

{
  # System-settings
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  
  # Networking
  networking.networkmanager.enable = true;
  
  # Set your time zone.
  time.timeZone = "Europe/Oslo";
  
  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  
  # Configure console keymap
  console.keyMap = "no";
  
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Define the user
  users.users.vegard = {
    isNormalUser = true;
    description = "Vegard Seines";
    extraGroups = [ "networkmanager" "wheel" ];
  };
}
