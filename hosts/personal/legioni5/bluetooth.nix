 { config, pkgs, ... }:

{
  # ... existing configuration ...

  systemd.services.fix-bluetooth-mt7925 = {
    description = "Fix MediaTek Bluetooth on Legion Pro 5i by resetting btusb";
    
    # Run this after the basic system is ready
    after = [ "multi-user.target" ];
    wantedBy = [ "multi-user.target" ];
    
    serviceConfig = {
      Type = "oneshot";
      # We need root to mess with kernel modules
      User = "root";
      
      # The script sequence:
      # 1. Stop bluetooth service to release the device
      # 2. Unload the btusb driver
      # 3. Wait 5 seconds (critical for the hardware to reset)
      # 4. Reload btusb (with autosuspend disabled, just in case)
      # 5. Start bluetooth service again
      ExecStart = pkgs.writeShellScript "reset-btusb" ''
        echo "Stopping Bluetooth service..."
        ${pkgs.systemd}/bin/systemctl stop bluetooth.service
        
        echo "Unloading btusb module..."
        ${pkgs.kmod}/bin/modprobe -r btusb
        
        echo "Waiting for hardware to reset..."
        sleep 5
        
        echo "Reloading btusb module..."
        ${pkgs.kmod}/bin/modprobe btusb enable_autosuspend=n
        
        echo "Restarting Bluetooth service..."
        ${pkgs.systemd}/bin/systemctl start bluetooth.service
      '';
      
      # Don't consider the service "failed" if it exits successfully
      RemainAfterExit = true;
    };
  };

  # Ensure you have the necessary firmware packages
  hardware.enableAllFirmware = true;
  hardware.bluetooth.enable = true;
}
