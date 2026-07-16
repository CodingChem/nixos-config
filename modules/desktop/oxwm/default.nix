{
  pkgs,
  config,
  ...
}:
{
  users.users.vegard.packages = with pkgs; [
    dmenu
    xclip
  ];
  services.displayManager.ly.enable = true;
  services.xserver.windowManager.oxwm.enable = true;
}
