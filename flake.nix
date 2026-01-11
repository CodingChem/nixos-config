{
  description = "My Nixos Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Keep the input here
    niri.url = "github:YaLTeR/niri";
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs: {
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
      
      # This line ensures 'inputs' is available in all your modules
      specialArgs = { inherit inputs; };
      
      modules = [
        ./hosts/personal/legioni5/configuration.nix
        ./modules/defaults.nix
        ./modules/game.nix
        
        # We load niri.nix, and WE WILL FIX niri.nix to import the modules itself
        ./modules/desktop/niri.nix
        
        ./modules/desktop/gnome.nix
        ./modules/desktop/defaults.nix

        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          
          # This ensures 'inputs' is available in Home Manager too
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
