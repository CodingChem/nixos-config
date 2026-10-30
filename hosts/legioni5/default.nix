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

  # --- KERNEL TUNING & SCHEDULER ---
  boot.kernelModules = [ "tcp_bbr" ];
  boot.kernelParams = [
    "i915.force_probe=7f2f"
    "split_lock_mitigate=0"
  ];

  boot.kernel.sysctl = {
    "vm.swappiness" = 10;
    "vm.max_map_count" = 2147483642;
    "net.core.default_qdisc" = "fq";
    "net.ipv4.tcp_congestion_control" = "bbr";
  };

  # Sched-ext: Latency-criticality Aware Virtual Deadline scheduler for Arrow Lake hybrid P/E cores
  services.scx = {
    enable = true;
    scheduler = "scx_lavd";
  };

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
