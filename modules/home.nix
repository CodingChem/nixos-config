{ config, pkgs, ... }:

{
  # User setup
  home.username = "vegard";
  home.homeDirectory = "/home/vegard";
  home.stateVersion = "25.11"; 

  # Apps
  home.packages = with pkgs; [
    fzf
    ripgrep
    fd
    bat    # En bedre 'cat' som ofte følger med i denne pakken
    eza    # En moderne erstatning for 'ls'
  ];

  # program settings
  programs = {
    home-manager.enable = true;
# Zsh konfigurasjon
    zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
      
      shellAliases = {
        nos = "sudo nixos-rebuild switch --flake ~/.config/nixos";
        ls = "eza --icons";
	ll = "eza --icons -l";
	la = "eza --icons -la";
	tree = "eza --icons --git-ignore --tree";
        cat = "bat";
      };
    };

    # Oh-my-posh med Catppuccin tema
    oh-my-posh = {
      enable = true;
      enableZshIntegration = true;
      # Vi bruker Catppuccin Mocha her
      useTheme = "catppuccin_mocha"; 
    };

    # Fzf integrasjon
    fzf = {
      enable = true;
      enableZshIntegration = true;
    };

    neovim = {
      enable = true;
      defaultEditor = true;
    };

    git = {
      enable = true;
      settings = {
        user = {
          name = "Vegard Pareli Seines";
          email = "vegsei@gmail.com";
        };
        init.defaultBranch = "main";
      };
    };
  };
}
