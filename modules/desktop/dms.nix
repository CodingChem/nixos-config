{ config, pkgs, ... }:

{
  imports  = [
    inputs.dms.nixosModules.dankMaterialShell
  ];
  programs.niri.enable = true;
  programs.dank-material-shell = {
    enable = true;
    systemd.enable = true;
    niri  = {
      enableKeybinds  = true;
      enableSpawn = true;
    };
    enableSystemMonitoring = true;
    enableClipboard = true;
    enableDynamicTheming = true;
    enableAudioWavelength = true;
    enableCalendarEvents = true;
  };
}
