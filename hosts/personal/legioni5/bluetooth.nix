 { config, pkgs, ... }:

{
  # Configure kernel parameters for Bluetooth
  boot.extraModprobeConfig = ''
    options btusb enable_autosuspend=n
  '';

  # Ensure the correct firmware and drivers are available (usually standard, but good to be safe)
  hardware.enableAllFirmware = true;
  
}
