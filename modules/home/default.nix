{ pkgs, catppuccin, ... }:

{
  imports = [
    ./neovim/default.nix
    ./terminal/default.nix
    catppuccin.homeModules.catppuccin
  ];

  # General home-manager settings that apply to everything
  home.username = "vegard";
  home.homeDirectory = "/home/vegard";
  home.stateVersion = "26.05"; 

  catppuccin.flavor = "macchiato";
  catppuccin.enable = true;
  catppuccin.autoEnable = true;

  # Basic packages you want everywhere
  home.packages = with pkgs; [
    google-chrome
    gh
  ];
  programs.git = {
    enable = true;
    settings.user = {
      name = "Vegard Pareli Seines";
      email = "vegsei@gmail.com";
    };
    settings.core = {
      editor = "nvim";
    };
  };

  programs.home-manager.enable = true;
}
