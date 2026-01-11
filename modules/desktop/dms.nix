{ config, pkgs, ... }:

{
  programs.niri.enable = true;
  programs.dankMaterialShell = {
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
