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
      tree-sitter
      unzip
      ripgrep
      fd
      vtsls
      vscode-langservers-extracted # contains eslint, html, css, json LSPs
      prettierd # faster daemonized prettier
      eslint_d   # faster daemonized eslint
      biome      # optional, fast alternative
    ];
  };

  xdg.configFile."nvim".source = ./config;
}
