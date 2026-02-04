{
  description = "My Nixos Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    mango = {
      url = "github:DreamMaoMao/mango";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    catppuccin.url = "github:catppuccin/nix";
  };

  outputs = { self, nixpkgs, home-manager, catppuccin, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
    in
    {

      devShells.${system}.suckless = pkgs.mkShell {
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
          ./modules/laptops/lid.nix

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
