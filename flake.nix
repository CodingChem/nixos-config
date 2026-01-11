{
  description = "My Nixos Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # 1. Input definition
    niri.url = "github:YaLTeR/niri";
  };

  # 2. Add 'niri' to the arguments here! 
  # This converts the input source into usable "outputs"
  outputs = { self, nixpkgs, home-manager, niri, ... }@inputs: {
    
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
        ./hosts/personal/legioni5/configuration.nix
        ./modules/defaults.nix
        ./modules/game.nix
        
        # Your Hybrid Niri file
        ./modules/desktop/niri.nix
        
        ./modules/desktop/gnome.nix
        ./modules/desktop/defaults.nix

        # 3. Use the 'niri' argument directly (NOT inputs.niri)
        niri.nixosModules.niri

        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.extraSpecialArgs = { inherit inputs; };
          home-manager.users.vegard = {
            imports = [
              ./modules/home.nix
              # 4. Same here
              niri.homeModules.niri
            ];
          };
        }
      ];
    };
  };
}
