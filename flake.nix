{
  description = "My Nixos Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # 1. Add the COSMIC flake input
    nixos-cosmic = {
      url = "github:lilyinstarlight/nixos-cosmic";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, nixos-cosmic, ... }@inputs: {
    nixosConfigurations.P14S = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs; };
      modules = [
        ./hosts/work/P14S/configuration.nix
        ./modules/defaults.nix
        ./modules/desktop/gnome.nix
        ./modules/desktop/defaults.nix

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
        # 2. Add the COSMIC module provided by the flake
        nixos-cosmic.nixosModules.default

        # 3. CRITICAL: Add Binary Cache to avoid compiling from source
        {
          nix.settings = {
            substituters = [ "https://cosmic.cachix.org/" ];
            trusted-public-keys = [ "cosmic.cachix.org-1:Dya9IyXD4xdBehWjXPe96e9mVBdPx154KZQ7D0UVFb4=" ];
          };
        }

        ./hosts/personal/legioni5/configuration.nix
        ./modules/defaults.nix
        ./modules/game.nix
        
        ./modules/desktop/dms.nix
        
        # 4. Swapped gnome.nix for cosmic.nix here
        ./modules/desktop/cosmic.nix 
        ./modules/desktop/defaults.nix
        
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
