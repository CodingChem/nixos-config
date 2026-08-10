{ config, pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      ls = "eza --icons auto";
      ll = "eza -l --icons auto";
      la = "eza -la --icons auto";
      lt = "eza --tree --icons auto --git-ignore";
      refresh = "nix flake update --flake ~/Repos/nixos-system/";
      update = "sudo nixos-rebuild switch --flake ~/Repos/nixos-system/";
      v = "nvim";
    };

    history = {
      size = 10000;
      path = "${config.home.homeDirectory}/.zsh_history";
    };

    # This ensures your plugins and fzf are initialized
    initContent = ''
      # Custom keybindings or extra init code can go here
    '';
  };

  # FZF Setup
  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };
  programs.eza.enable = true;
}
