{ config, pkgs, ... }:

{
  # User setup
  home.username = "vegard";
  home.homeDirectory = "/home/vegard";
  home.stateVersion = "25.11"; 

  # Apps
  home.packages = with pkgs; [
  ];

  # program settings
  programs = {
    home-manager.enable = true;

    neovim = {
      enable = true;
      defaultEditor = true;
    };

    git = {
      enable = true;
      settings = {
        user = {
          name = "Vegard Pareli Seines";
          email = "vegsei@gmail.com";
        };
        init.defaultBranch = "main";
      };
    };
  };
}
