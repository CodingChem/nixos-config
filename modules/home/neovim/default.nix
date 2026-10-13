{ pkgs, config, ... }:

{
  home.packages = with pkgs; [
    neovim
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
    vscode-langservers-extracted
    prettierd
    eslint_d
    biome
    kdePackages.qtdeclarative
  ];

  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
  };

  xdg.configFile."nvim".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/Repos/nixos-system/modules/home/neovim/nvim";
}
