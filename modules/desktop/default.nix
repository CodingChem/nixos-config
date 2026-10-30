{ config, pkgs, lib, ... }:
with lib;

let
  cfg = config.myDesktop;

  # Package all scripts inside ./scripts into a single system package
  myDesktopScripts = pkgs.stdenv.mkDerivation {
    name = "mydesktop-scripts";
    src = ./scripts;
    installPhase = ''
      mkdir -p $out/bin
      cp -r * $out/bin/
      chmod +x $out/bin/*
    '';
  };
in
{
  options.myDesktop = {
    enable = mkEnableOption "Enable core desktop environment settings";

    environment = mkOption {
      type = types.nullOr (types.enum [ "gnome" "hyprland" "oxwm" "cosmic" ]);
      default = null;
      description = "The primary environment to enable.";
    };
  };

  imports = [
    ./gnome/default.nix
    ./hyprland/default.nix
    ./oxwm/default.nix
    ./cosmic/default.nix
  ];

  config = mkIf cfg.enable {
    # Printing & power management
    services.printing.enable = true;
    services.upower.enable = true;

    # Security & keyrings
    services.gnome.gnome-keyring.enable = true;
    programs.seahorse.enable = true;
    services.dbus.packages = [ pkgs.gnome-keyring pkgs.gcr_4 ];
    services.gnome.gcr-ssh-agent.enable = true;

    # Audio stack (Pipewire)
    services.pulseaudio.enable = false;
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };

    # DNS resolution
    services.resolved.enable = true;
    networking.networkmanager.dns = "systemd-resolved";
    services.resolved.settings.Resolve.FallbackDNS = [ "1.1.1.1" "8.8.8.8" ];

    # Common desktop utilities
    environment.systemPackages = [
      myDesktopScripts
      pkgs.playerctl
      pkgs.brightnessctl
      pkgs.beeper
      pkgs.microsoft-edge
    ];
  };
}
