{
  description = "My Nixos Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  # 2. Add 'niri' to the arguments here
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
        
        # Your Niri config file
        ./modules/desktop/niri.nix
        
        ./modules/desktop/gnome.nix
        ./modules/desktop/defaults.nix
        
        # 3. Load the System Module DIRECTLY here
        # This fixes "missing attribute" errors
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.extraSpecialArgs = { inherit inputs; };
          
          home-manager.users.vegard = {
            imports = [
              ./modules/home.nix
              # 4. Load the Home Manager Module DIRECTLY here
              niri.homeModules.niri
            ];
          };
        }
      ];
    };
  };
}
