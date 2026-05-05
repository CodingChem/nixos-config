{
  description = "My Nixos configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = { self, nixpkgs, home-manager, ... }: {
      nixosConfigurations.e15 = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
	  modules = [
	      ./hosts/e15/default.nix
	      home-manager.nixosModules.home-manager
	  ];
      };
  };
}
