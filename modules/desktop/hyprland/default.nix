{ pkgs, inputs, ...}:
{
  users.users.vegard.packages = with pkgs; [
    rofi
    thunar
    swaybg
  ];
  services.displayManager.ly.enable = true;
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
    package = inputs.hyprland.packages.${pkgs.system}.hyprland;
    portalPackage = inputs.hyprland.packages.${pkgs.system}.xdg-desktop-portal-hyprland;
  };
}
