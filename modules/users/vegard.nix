
{ config, pkgs, ... }:

{
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.vegard = {
    isNormalUser = true;
    description = "Vegard Seines";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
    #  thunderbird
    ];
  };
  programs = {
    neovim = {
      enable = true;
      defaultEditor = true;
    };
    git = {
      enable = true;
      settings = {
        user = {
	  name = "Vegard Pareli Seines";
	  email = "vegsei@gmail.com";
	};
	init.defaultBranch = "main";
      };
    };
  };
}
