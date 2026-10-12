{ pkgs, config, ... }:

{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    extraPackages = with pkgs; [
      lua-language-server
      stylua
      nil
      gcc
      gnumake
      tree-sitter
      unzip
      ripgrep
      fd
      emmet-language-server
      vtsls
      vscode-langservers-extracted # contains eslint, html, css, json LSPs
      prettierd # faster daemonized prettier
      eslint_d   # faster daemonized eslint
      biome      # optional, fast alternative
      kdePackages.qtdeclarative
    ];
  };
  xdg.configFile."nvim".source = 
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/Repos/nixos-system/modules/home/neovim/nvim";
}
