{ config, pkgs, lib, ... }:

{
  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Install firefox.
  programs.chromium.enable = true;
}
