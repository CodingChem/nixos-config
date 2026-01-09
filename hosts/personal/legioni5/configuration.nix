# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

# 1. Tving btusb-modulen til å laste
  boot.kernelModules = [ "btusb" ];

systemd.services.force-mediatek-bluetooth = {
    description = "Brute-force MediaTek Bluetooth initialization";
    after = [ "network.target" "bluetooth.service" ];
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
      ExecStart = pkgs.writeScript "force-bluetooth" ''
        #!${pkgs.bash}/bin/bash
        
        # Vent opptil 30 sekunder på at driver-mappen i det hele tatt eksisterer
        for i in {1..30}; do
          if [ -f /sys/bus/usb/drivers/btusb/new_id ]; then
            echo "btusb driver funnet etter $i sekunder."
            break
          fi
          sleep 1
        done

        # Forsøk å tvinge inn ID-en 5 ganger med litt mellomrom
        for i in {1..5}; do
          echo "Forsøk $i: Skriver ID til new_id..."
          echo "0489 e111" > /sys/bus/usb/drivers/btusb/new_id || true
          sleep 2
          
          # Sjekk om kontrolløren har dukket opp i bluetoothctl
          if ${pkgs.bluez}/bin/bluetoothctl list | grep -q "Controller"; then
            echo "Suksess! Bluetooth-kontroller funnet."
            ${pkgs.systemd}/bin/systemctl restart bluetooth.service
            exit 0
          fi
        done

        echo "Feilet: Kontrolleren dukket aldri opp."
        exit 1
      '';
    };
  };

  # 3. Udev-regler (Kun for å blokkere GVFS nå)
  services.udev.extraRules = ''
    SUBSYSTEM=="usb", ATTR{idVendor}=="0489", ATTR{idProduct}=="e111", ENV{ID_MEDIA_PLAYER}="0", ENV{ID_GPM}="0", ENV{ID_MTP_DEVICE}="0"
  '';

  # 4. HWDB (Behold som før)
  services.udev.extraHwdb = ''
    usb:v0489pE111*
     ID_MEDIA_PLAYER=0
  '';

  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = "legioni5"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.11"; # Did you read the comment?

}
