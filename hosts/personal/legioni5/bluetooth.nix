{ config, pkgs, ... }:

{
# 1. Enable Bluetooth
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;

  # 2. Fix for MediaTek MT7925e (0489:e111) 
  # This rule overrides the bad 'hwdb' entry that the script was trying to delete.
  # It forces the system to stop treating the Bluetooth card as a Camera/Media Player.
  services.udev.extraRules = ''
    SUBSYSTEM=="usb", ATTR{idVendor}=="0489", ATTR{idProduct}=="e111", ENV{ID_MTP_DEVICE}="0", ENV{ID_GPHOTO2}="0", ENV{ID_MEDIA_PLAYER}="0"
  '';
}
