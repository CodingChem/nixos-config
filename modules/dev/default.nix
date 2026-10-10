{ pkgs, ... }:

{
  imports = [
    ./android.nix
  ];
  virtualisation.docker = {
    enable = true;
  };
  users.users.vegard.extraGroups = [ "dialout" ];
  services.udev.packages = [ pkgs.platformio-core.udev ];
  home-manager.users.vegard = {
    programs.direnv = {
      enable = true;
      nix-direnv.enable = true;
      enableZshIntegration = true;
    };
  };
  environment.systemPackages = with pkgs; [
    emacs-pgtk
    antigravity-cli
    antigravity-ide
    fd
    ripgrep
    git
    uv
    (texlive.withPackages (ps: with ps; [
scheme-medium
  latexmk

  # Fonts, microtypography & encoding
  microtype
  pdfcol

  # Math, tables, layout & graphics
  amsmath
  booktabs
  caption         # provides caption and subcaption
  geometry
  setspace
  fancyhdr

  # TikZ & PGF extensions
  pgfplots
  eso-pic
  ifoddpage
  tikzfill
  tcolorbox

  # Algorithms, code & citations
  algorithm2e
  relsize
  listings
  natbib

  # Navigation & referencing
  enumitem
  hyperref
  cleveref
    ]))
    ];
}
