{ pkgs, ... }:

{
  imports = [
    ./android.nix
  ];
  virtualisation.docker = {
    enable = true;
  };
  home-manager.users.vegard = {
    programs.direnv = {
      enable = true;
      nix-direnv.enable = true;
      enableZshIntegration = true;
    };
  };
}
