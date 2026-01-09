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
      userName = "Vegard Pareli Seines";
      userEmail = "vegsei@gmail.com";
      extraConfig = {
        init.defaultBranch = "main";
      };
    };
  };
}
