{ config, lib, pkgs, ... }:
with lib;

let
  cfg = config.mySystem.user;
in
{
  options.mySystem.user = {
    name = mkOption {
      type = types.str;
      default = "vegard";
      description = "Primary system username.";
    };

    fullName = mkOption {
      type = types.str;
      default = "Vegard Pareli Seines";
      description = "Full name of the primary user.";
    };

    email = mkOption {
      type = types.str;
      default = "vegsei@gmail.com";
      description = "Email of the primary user.";
    };
  };

  config = {
    users.users.${cfg.name} = {
      isNormalUser = true;
      description = cfg.fullName;
      extraGroups = [ "networkmanager" "wheel" "kvm" cfg.name "groups" "dialout" "docker" ];
      shell = pkgs.zsh;
      packages = with pkgs; [
        zip
        unzip
        wget
        curl
        fzf
        ripgrep
        bat
        fd
      ];
    };

    home-manager.users.${cfg.name} = {
      imports = [ ../home/default.nix ];
    };
  };
}
