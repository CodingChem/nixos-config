{ config, pkgs, ... }:

{
  # 1. The Core Fix: Tell the kernel to disable Link Power Management (LPM) for this ID.
  # '0489:e111' is your device. 'k' means USB_QUIRK_NO_LPM.
  boot.kernelParams = [ "usbcore.quirks=0489:e111:k" ];

  # 2. Keep the software-level autosuspend disabled as a backup
  boot.extraModprobeConfig = ''
    options btusb enable_autosuspend=n
  '';

  # 3. Hardware database fix (Keep this to prevent GNOME interfering)
  services.udev.extraHwdb = ''
    usb:v0489pE111*
     ID_GPHOTO2=0
     ID_MTP_DEVICE=0
     ID_MEDIA_PLAYER=0
  '';

  # Standard Bluetooth enabling
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
}
