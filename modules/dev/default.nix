{ config, lib, pkgs, ... }:
with lib;

let
  cfg = config.mySystem.dev;
in
{
  options.mySystem.dev = {
    enable = mkEnableOption "Enable baseline development tools (Docker, Node, Python LSP, Emacs, Git, uv)";
    android.enable = mkEnableOption "Enable Android Studio, emulator tools, and nix-ld library bridges";
    latex.enable = mkEnableOption "Enable TeX Live medium scheme and LaTeX tooling";
  };

  imports = [
    ./android.nix
  ];

  config = mkMerge [
    (mkIf cfg.enable {
      virtualisation.docker.enable = true;
      services.udev.packages = [ pkgs.platformio-core.udev ];
      environment.systemPackages = with pkgs; [
        nodejs
        pyright
        ruff
        emacs-pgtk
        antigravity-cli
        antigravity-ide
        fd
        ripgrep
        git
        uv
      ];
    })

    (mkIf (cfg.enable && cfg.latex.enable) {
      environment.systemPackages = [
        (pkgs.texlive.withPackages (ps: with ps; [
          scheme-medium
          latexmk

          # Fonts, microtypography & encoding
          microtype
          pdfcol

          # Math, tables, layout & graphics
          amsmath
          booktabs
          caption
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
    })
  ];
}
