{ pkgs, catppuccin, ... }:

{
  imports = [
    ./neovim/default.nix  # This is the line you wanted!
    ./kitty.nix
    catppuccin.homeModules.catppuccin
  ];

  # General home-manager settings that apply to everything
  home.username = "vegard";
  home.homeDirectory = "/home/vegard";
  home.stateVersion = "26.05"; 

  catppuccin.flavor = "macchiato";
  catppuccin.enable = true;

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
