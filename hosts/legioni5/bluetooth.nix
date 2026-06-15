{ config, pkgs, ... }:

{
  # 1. Enable Bluetooth
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;

  # 2. Keep the MediaTek card fully powered at the kernel level
  boot.kernelParams = [ 
    "btusb.enable_autosuspend=n" 
    "pcie_aspm=off"
    "usbcore.autosuspend=-1"
  ];

  # 3. Force cold-resets to prevent the broken WMT firmware download loop
  boot.extraModprobeConfig = ''
    options btusb disable_scofix=1 enable_autosuspend=0 reset=1
  '';

  # 4. Ensure latest MediaTek microcode is available
  hardware.enableAllFirmware = true;
}
