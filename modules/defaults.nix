{ config, pkgs, ... }:

{
  # System-settings
  nix = {
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      trusted-users = [ "root" "vegard" ];
      auto-optimise-store = true;
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 30d";
    };
  };

  # Allow unfree packages
  nixpkgs.config = {
    allowUnfree = true;
  };
  # Networking
  networking.networkmanager.enable = true;
  networking.networkmanager.wifi.powersave = false;
  # Enable BBR Congestion Control
  boot.kernel.sysctl = {
    "net.core.default_qdisc" = "fq";
    "net.ipv4.tcp_congestion_control" = "bbr";
  };
  networking.nameservers = [ "1.1.1.1" "8.8.8.8" ];
  networking.networkmanager.wifi.backend = "iwd";
  # Set your time zone.
  time.timeZone = "Europe/Oslo";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  # Configure console keymap
  console.keyMap = "no";
  services.xserver.xkb.layout = "no";

  virtualisation.docker = {
    enable = true;
    enableOnBoot = true;
  };

  programs.zsh.enable = true;
  # Define the user
  users.users.vegard = {
    isNormalUser = true;
    description = "Vegard Seines";
    extraGroups = [ "networkmanager" "wheel" "docker" "kvm" ];
    shell = pkgs.zsh;
  };
  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];
}
