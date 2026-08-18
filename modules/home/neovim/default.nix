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
    plugins = with pkgs.vimPlugins; [
      (nvim-treesitter.withPlugins (p: [
        p.nix
        p.lua
        p.bash
        p.python
        p.c
        p.javascript
        p.html
        p.css
        p.kotlin
        p.c_sharp
        p.typescript
        p.tsx
      ]))
    ];
  };
  xdg.configFile."nvim".source = ./config;
}
