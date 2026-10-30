{ pkgs, catppuccin, config, osConfig, ... }:

{
  imports = [
    ./neovim/default.nix
    ./terminal/default.nix
    catppuccin.homeModules.catppuccin
  ];

  # Derive identity from the primary system user seam
  home.username = osConfig.mySystem.user.name;
  home.homeDirectory = "/home/${osConfig.mySystem.user.name}";
  home.stateVersion = "26.05"; 

  catppuccin = {
    enable = true;
    flavor = "macchiato";
    autoEnable = true;
    nvim.enable = false;
    tmux = {
      enable = true;
    };
  };

  home.sessionPath = [
    "$HOME/.local/bin"
  ];

  # Basic packages you want everywhere
  home.packages = with pkgs; [
    google-chrome
    gh
    libnotify
    opencode
    herdr
    yazi
  ];

  programs.git = {
    enable = true;
    settings.user = {
      name = osConfig.mySystem.user.fullName;
      email = osConfig.mySystem.user.email;
    };
    settings.core = {
      editor = "nvim";
    };
  };

  # Shell environment integration
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
    enableZshIntegration = true;
  };

  # Config mapping with symlinks
  xdg.configFile."doom".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/Repos/nixos-system/modules/home/doom";
  services.dunst.enable = true;

  programs.home-manager.enable = true;
}
