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

  catppuccin = {
    enable = true;
    flavor = "macchiato";
    autoEnable = true;
    tmux = {
      enable = true;
    };
  };

  # Basic packages you want everywhere
  home.packages = with pkgs; [
    google-chrome
    gh
    libnotify
    opencode
    herdr
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
  services.dunst.enable = true;

  programs.home-manager.enable = true;
}
