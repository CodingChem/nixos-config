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
      type = types.nullOr (types.enum [ "dwm" "hyprland" "cosmic" "gnome" "oxwm" "noctalia" ]);
      default = null;
      description = "The primary environment to enable.";
    };
  };

  imports = [
    ./oxwm/default.nix
    ./hyprland/default.nix
    ./noctalia/default.nix
  ];

  config = mkIf cfg.enable (mkMerge [
      {
# Configure keymap in X11
      services.xserver.xkb = {
      layout = "no";
      variant = "";
      };
# Configure console keymap
      console.keyMap = "no";

# Enable CUPS to print documents.
      services.printing.enable = true;

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
      environment.systemPackages = [
        myDesktopScripts
        pkgs.playerctl
        pkgs.brightnessctl
        pkgs.beeper
      ];
      }
  (mkIf (cfg.environment == "oxwm") {
   myoxwm.enable = true;
   })
  (mkIf (cfg.environment == "hyprland") {
   myhyprland.enable = true;
   })
  (mkIf (cfg.environment == "noctalia") {
   mynoctalia.enable = true;
   })
  ]);
}
