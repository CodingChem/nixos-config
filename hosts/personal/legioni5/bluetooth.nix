 { config, pkgs, ... }:

{
# 1. Fix the "False Identity" bug where GNOME thinks the Bluetooth chip is a Camera/MP3 player
  services.udev.extraHwdb = ''
    # Match Foxconn / Hon Hai Wireless_Device (0489:e111)
    usb:v0489pE111*
     ID_GPHOTO2=0
     ID_MTP_DEVICE=0
     ID_MEDIA_PLAYER=0
  '';

  # 2. Keep the "Clean" power management fix just in case (optional but recommended)
  boot.extraModprobeConfig = ''
    options btusb enable_autosuspend=n
  '';

  # Ensure you have the necessary firmware packages
  hardware.enableAllFirmware = true;
  hardware.bluetooth.enable = true;
}
