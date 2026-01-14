{ config, pkgs, ... }:

{
# 1. Enable Bluetooth (Standard)
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;

  # 2. THE FIX: Override the Hardware Database
  # The original script deleted the "bad" rule. We cannot delete in NixOS, 
  # so we overwrite the properties to "0" (False).
  # Note: The indentation of the properties (ID_...) is required.
  services.udev.extraHwdb = ''
    usb:v0489pE111*
     ID_MTP_DEVICE=0
     ID_GPHOTO2=0
     ID_MEDIA_PLAYER=0
  '';
}
