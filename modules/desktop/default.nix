{ config, pkgs, ... }:
with lib;

let
  cfg = config.myDesktop;
in
{
  options.myDesktop = {
    enable = mkEnableOption "Enable core desktop environment settings";

    environment = mkOption {
      type = types.nullOr (types.enum [ "dwm" "hyprland" "cosmic" "gnome" "oxwm" ]);
      default = null;
      description = "The primary environment to enable.";
    };
  };

  imports = [
    (lib.optional (cfg.environment == "oxwm") ./oxwm/default.nix)
  ];

  config = mkIf cfg.enable {
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
  };
}
