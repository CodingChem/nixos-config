
{ config, pkgs, ... }:

{

  # --- BLUETOOTH & KERNEL FIXES ---

  # 1. Bruk nyeste kjerne (viktig for Arrow Lake og 50-serien)
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # 2. Tving drivermoduler og deaktiver aggressiv strømsparing på USB/BT
  boot.kernelModules = [ "btusb" ];
  boot.blacklistedKernelModules = [ "ideapad_laptop" ]; # Hindrer rfkill-konflikt
boot.kernelParams = [ 
    "usbcore.autosuspend=-1" 
    "btusb.enable_autosuspend=n"
    "i915.force_probe=7f2f"
    "btusb.disable_scofix=1" # Legg til denne!
  ];

  # 3. Den forbedrede Brute-force tjenesten
  systemd.services.force-mediatek-bluetooth = {
    description = "Brute-force MediaTek Bluetooth initialization";
    after = [ "network.target" "bluetooth.service" ];
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
      ExecStart = pkgs.writeScript "force-bluetooth" ''
        #!${pkgs.bash}/bin/bash
        # Vent på sysfs
        for i in {1..15}; do
          [ -f /sys/bus/usb/drivers/btusb/new_id ] && break
          sleep 1
        done

        # Tving ID og vekk kontrolleren
        echo "0489 e111" > /sys/bus/usb/drivers/btusb/new_id || true
        sleep 2

        # Tving kontrolleren til å være 'UP' i tilfelle den starter som 'DOWN'
        ${pkgs.bluez}/bin/hciconfig hci0 up || true
        
        # Restart tjenesten for å plukke opp endringen
        ${pkgs.systemd}/bin/systemctl restart bluetooth.service
      '';
    };
  };

  # 4. Hardware-regler for å stoppe GVFS/Gnome fra å stjele enheten
  services.udev.extraRules = ''
    SUBSYSTEM=="usb", ATTR{idVendor}=="0489", ATTR{idProduct}=="e111", ENV{ID_MEDIA_PLAYER}="0", ENV{ID_GPM}="0", ENV{ID_MTP_DEVICE}="0", ATTR{power/control}="on"
  '';

  services.udev.extraHwdb = ''
    usb:v0489pE111*
     ID_MEDIA_PLAYER=0
  '';

  # 5. Aktiver Bluetooth ordentlig
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };
