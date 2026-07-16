{ config, pkgs, ... }:

{
  imports = [ 
    ./hardware-configuration.nix 
    ./configuration.nix
    ../../modules/shared/defaults.nix
    ../../modules/desktop/cosmic/default.nix
    ../../modules/desktop/default.nix
    ../../modules/apps/default.nix
  ];

  # Standard NixOS system settings (bootloader, networking, etc.)
  # ...

  # Home Manager setup inside the host config
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.vegard = {
      imports = [
        ../../modules/home/default.nix # General settings
        ./home.nix                     # E15-specific settings
      ];
    };
  };

  # ... the rest of your system config
}
