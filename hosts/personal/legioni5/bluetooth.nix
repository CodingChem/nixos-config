
{ config, pkgs, ... }:

{

  # I stedet for et komplisert skript, forteller vi driveren direkte om ID-en
  # Dette tilsvarer det du gjorde manuelt, men skjer idet modulen laster.
  boot.extraModprobeConfig = ''
    install btusb ${pkgs.kmod}/bin/modprobe --ignore-install btusb; echo 0489 e111 > /sys/bus/usb/drivers/btusb/new_id
  '';

  boot.kernelModules = [ "btusb" ];
  
  # Hindrer at laptopen prøver å styre strømmen til Bluetooth (som ofte dreper MediaTek)
  boot.blacklistedKernelModules = [ "ideapad_laptop" ];
  
  boot.kernelParams = [ 
    "usbcore.autosuspend=-1" 
    "btusb.enable_autosuspend=n"
    "btusb.disable_scofix=1"
    "i915.force_probe=7f2f" 
  ];

  # Aktiver standard bluetooth-støtte
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
