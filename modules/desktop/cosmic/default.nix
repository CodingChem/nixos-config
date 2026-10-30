{ config, lib, pkgs, ...}:
let
  cfg = config.myDesktop;
in
{
  config = lib.mkIf (cfg.enable && cfg.environment == "cosmic") {
    # Enable the COSMIC login manager
    services.displayManager.cosmic-greeter.enable = true;

    # Enable the COSMIC desktop environment
    services.desktopManager.cosmic.enable = true;
    services.system76-scheduler.enable = true;
  };
}
