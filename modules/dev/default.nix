{ pkgs, ... }:

{
  imports = [
    ./android.nix
  ];
  virtualisation.docker = {
    enable = true;
  };
  home-manager.users.vegard = {
    programs.direnv = {
      enable = true;
      nix-direnv.enable = true;
      enableZshIntegration = true;
    };
  };
  environment.systemPackages = with pkgs; [
    emacs-pgtk
    fd
    ripgrep
    git
    uv
    (texlive.withPackages (ps: with ps; [
      scheme-medium
      latexmk
    ]))
    ];
}
