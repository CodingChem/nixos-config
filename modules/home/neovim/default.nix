{ pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    extraPackages = with pkgs; [
      lua-language-server
      nil
      gcc
      gnumake
      unzip
      ripgrep
      fd
    ];
  };

  xdg.configFile."nvim".source = ./config;
}
