{ config, pkgs, ... }:

{
  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  
  # System setup
  networking.hostName = "e15"; # Define your hostname.
  services.fwupd.enable = true;
  zramSwap.enable = true;

  # --- AUDIO (Pipewire) ---
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };
  # Swap
  boot.resumeDevice = "/dev/disk/by-uuid/feedd2a5-1513-4745-970e-0c8993f9fb32";
  boot.kernelParams = [ "resume=UUID=feedd2a5-1513-4745-970e-0c8993f9fb32" ];
  powerManagement.enable = true;

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    wget
    google-chrome
    git
    gemini-cli
    gh
  ];
  system.stateVersion = "25.11"; # Did you read the comment?

  environment.sessionVariables = {
    XKB_DEFAULT_LAYOUT = "no";
  };
  services.xserver.xkb = {
    layout = "no";
    variant = "";
  };
  console.keyMap = "no";
}
