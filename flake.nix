{
  description = "My Nixos Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs:
  let
    x86 = "x86_64-linux";
    pkgs = import nixpkgs { inherit system; };
  in
  {

    devShells.${x86}.suckless = pkgs.mkShell {
      packages = with pkgs; [
        pkg-config
	xorg.libX11
	xorg.libXft
	xorg.libXinerama
	fontconfig
	freetype
	harfbuzz
	gcc
	gnumake
      ];
    };

    nixosConfigurations.P14S = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs; };
      modules = [
        ./hosts/P14S/configuration.nix
        ./modules/defaults.nix
        ./desktop/defaults.nix
	#./desktop/cosmic.nix
	./desktop/dwm.nix

        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.extraSpecialArgs = { inherit inputs; };
          home-manager.users.vegard = import ./modules/home.nix;
        }
      ];
    };

    nixosConfigurations.legioni5 = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs; };
      modules = [
        ./hosts/legioni5/configuration.nix
        ./modules/defaults.nix
        ./modules/game.nix
        ./desktop/cosmic.nix 
        ./desktop/defaults.nix
        
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.extraSpecialArgs = { inherit inputs; };
          
          home-manager.users.vegard = {
            imports = [
              ./modules/home.nix
            ];
          };
        }
      ];
    };
  };
}
