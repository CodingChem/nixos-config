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

# 1. Tving btusb-modulen til å laste ved oppstart
  boot.kernelModules = [ "btusb" ];

  # 2. Legg til en udev-regel som tvinger enheten til å bruke btusb-driveren
  # Dette overstyrer at den blir sett på som en "Wireless_Device"
  services.udev.extraRules = ''
    SUBSYSTEM=="usb", ATTR{idVendor}=="0489", ATTR{idProduct}=="e111", MODE="0660", GROUP="bluetooth", CONTROL{node}="0", ENV{ID_USB_INTERFACES}="*:ff0101:*", RUN+="${pkgs.kmod}/bin/modprobe btusb"
  '';

  # 3. HWDB fixen vi snakket om (viktig for MediaTek)
  services.udev.extraHwdb = ''
    usb:v0489pE111*
     ID_MEDIA_PLAYER=0
  '';

  # 4. Sørg for at bluetooth-tjenesten er konfigurert riktig
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings.General.AutoEnable = true;
  };

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
