{ config, pkgs, ... }:

{
  imports = [
    ./neovim/default.nix  # This is the line you wanted!
    # You can add more later, e.g., ./git.nix or ./zsh.nix
  ];

  # General home-manager settings that apply to everything
  home.username = "vegard";
  home.homeDirectory = "/home/vegard";
  home.stateVersion = "25.11"; 

  # Basic packages you want everywhere
  home.packages = with pkgs; [
  ];
  programs.git = {
    enable = true;
    settings.user = {
      name = "Vegard Pareli Seines";
      email = "vegsei@gmail.com";
    };
  };

  programs.home-manager.enable = true;
}
