{
  description = "My Nixos configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };
  outputs = { self, nixpkgs, ... }: {
      nixosConfigurations.e15 = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
	  modules = [
	      ./hosts/e15/configuration.nix
	  ];
      };
  };
}
