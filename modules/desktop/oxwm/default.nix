{
  pkgs,
  config,
  ...
}:
{
  environment.systemPackages = with pkgs; [
    dmenu
    kitty
    xclip
  ];
  services.displayManager.ly.enable = true;
  services.xserver.windowManager.oxwm.enable = true;
  services.xserver.enable = true;
}
