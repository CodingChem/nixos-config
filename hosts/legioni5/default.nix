{ config, pkgs, ... }:

{
  imports = [ 
    ./hardware-configuration.nix 
    ./bluetooth.nix
  ];

  # --- BOOTLOADER ---
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # --- FIRMWARE ---
  services.fwupd.enable = true;

  # --- HARDWARE GRAPHICS ---
  hardware.graphics = {
    enable = true;
    enable32Bit = true; # Required for Steam
    extraPackages = with pkgs; [
      egl-wayland
      libva-utils
      vdpauinfo
      mangohud
    ];
    extraPackages32 = with pkgs; [
      pkgsi686Linux.mangohud
    ];
  };

  # Load Nvidia driver
  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
    # Required for Wayland/GNOME
    modesetting.enable = true;

    # Laptop power management
    powerManagement.enable = true;
    dynamicBoost.enable = true;

    # Open kernel module (recommended for RTX 50-series)
    open = true;

    # Production driver package
    package = config.boot.kernelPackages.nvidiaPackages.stable;

    prime = {
      sync.enable = true;
      intelBusId = "PCI:0:2:0";
      nvidiaBusId = "PCI:2:0:0";
    };
  };

  # Intel Arrow Lake integrated graphics probe
  boot.kernelParams = [ "i915.force_probe=7f2f" ];

  # --- DESKTOP PROFILE ---
  myDesktop = {
    enable = true;
    environment = "gnome";
  };

  # --- SYSTEM CAPABILITIES ---
  mySystem.gaming.enable = true;
  mySystem.dev = {
    enable = true;
    android.enable = true;
    latex.enable = true;
  };

  # --- SYSTEM VERSION ---
  system.stateVersion = "25.11";
}
