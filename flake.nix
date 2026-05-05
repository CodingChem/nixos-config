{
  description = "My Nixos configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    catppuccin.url = "github:catppuccin/nix";
  };
  outputs = { self, nixpkgs, home-manager, catppuccin, ... }: {
      nixosConfigurations.e15 = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { inherit catppuccin; };
	  modules = [
	      ./hosts/e15/default.nix
	      home-manager.nixosModules.home-manager
        {
          home-manager.extraSpecialArgs = { inherit catppuccin; };
        }
	  ];
      };
  };
}
