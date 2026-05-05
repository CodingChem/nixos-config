{ config, pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      ll = "ls -l";
      update = "sudo nixos-rebuild switch --flake .";
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
}
