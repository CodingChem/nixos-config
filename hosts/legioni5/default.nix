{ config, pkgs, ... }:

{
  imports = [ 
    ./hardware-configuration.nix 
    ./configuration.nix
    ./bluetooth.nix
    ../../modules/shared/defaults.nix
    ../../modules/desktop/oxwm/default.nix
    ../../modules/desktop/default.nix
    ../../modules/apps/default.nix
    ../../modules/dev/default.nix
  ];

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.vegard = {
      imports = [
        ../../modules/home/default.nix
      ];
    };
  };

}
