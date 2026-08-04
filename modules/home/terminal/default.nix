{ pkgs, ... }:
{
  imports = [
    ./kitty.nix
    ./zsh.nix
    ./tmux.nix
  ];
}
