{ pkgs, ... }:

{
  # ... existing config ...

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    nerd-fonts.fira-code
    # You can add others like nerd-fonts.meslo-lg or nerd-fonts.hack
  ];
}
