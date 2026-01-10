{ config, pkgs, ... }:

{
  # 1. Tving ID-en inn i btusb-driveren med en gang modulen laster
  # Dette simulerer det manuelle skriptet ditt, men skjer automatisk.
  boot.extraModprobeConfig = ''
    install btusb ${pkgs.kmod}/bin/modprobe --ignore-install btusb; echo 0489 e111 > /sys/bus/usb/drivers/btusb/new_id
  '';

  # 2. Last modulen og legg til parametere som hindrer krasj
  boot.kernelModules = [ "btusb" ];
  boot.blacklistedKernelModules = [ "ideapad_laptop" ];
  boot.kernelParams = [ 
    "usbcore.autosuspend=-1" 
    "btusb.enable_autosuspend=n"
    "btusb.disable_scofix=1" 
  ];

  # 3. Aktiver Bluetooth-tjenesten
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };
} # <--- Sjekk at du har denne lukkeklammen!
