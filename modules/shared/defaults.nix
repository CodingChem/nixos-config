{ pkgs, ... }:

{
  # ... existing config ...

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    nerd-fonts.fira-code
    # You can add others like nerd-fonts.meslo-lg or nerd-fonts.hack
  ];
  programs.zsh.enable = true;
  # services.xserver.libinput.enable = true;
  nix.settings = {
      experimental-features = [ "nix-command" "flakes" ];
      auto-optimise-store = true;
  };
  nix.gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
  };

  users.users.vegard = {
    isNormalUser = true;
    description = "Vegard Pareli Seines";
    extraGroups = [ "networkmanager" "wheel" "kvm" "vegard" ];
    packages = with pkgs; [
    ];
  };
  users.users.vegard.shell = pkgs.zsh;

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Oslo";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "nb_NO.UTF-8";
    LC_IDENTIFICATION = "nb_NO.UTF-8";
    LC_MEASUREMENT = "nb_NO.UTF-8";
    LC_MONETARY = "nb_NO.UTF-8";
    LC_NAME = "nb_NO.UTF-8";
    LC_NUMERIC = "nb_NO.UTF-8";
    LC_PAPER = "nb_NO.UTF-8";
    LC_TELEPHONE = "nb_NO.UTF-8";
    LC_TIME = "nb_NO.UTF-8";
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

}
