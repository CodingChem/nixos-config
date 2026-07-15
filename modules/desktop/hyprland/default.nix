{ pkgs, hyprland, ...}:
{
  users.users.vegard = {
    rofi
    thunar
    swaybg
  };
  services.displayManager.ly.enable = true;
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
    package = hyprland.packages.${pkgs.system}.hyprland;
    portalPackage = hyprland.packages.${pkgs.system}.xdg-desktop-portal-hyprland;
  };
}
