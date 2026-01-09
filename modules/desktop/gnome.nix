{ config, pkgs, lib, ... }:

{
  # --- System settings ---
  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "no";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Install firefox.
  programs.firefox.enable = true;
  environment.gnome.excludePackages = (with pkgs; [
    gnome-tour
    gnome-maps
    gnome-weather
    geary
  ]);
  home-manager.users.vegard = {
    dconf.settings = {
      "org/gnome/desktop/interface" = {
        color-scheme  ="prefer-dark";
	gtk-theme = "Adwaita-dark";
      };
      "org/gnome/desktop/wm/preferences" = {
        button-layout = "appmenu:minimize,maximize,close";
      };
      "org/gnome/settings-daemon/plugins/media-keys" = {
        custom-keybindings = [ "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/" ];
      };
      "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
        binding = "<Super><Return>";
	command = "ghostty";
	name = "Open Ghostty";
      };
    };
  };
}
