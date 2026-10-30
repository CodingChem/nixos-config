{
  description = "My Nixos configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    hyprland.url = "github:hyprwm/Hyprland/v0.55.0";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    catppuccin.url = "github:catppuccin/nix";
  };

  outputs = inputs @ { 
    self, 
    nixpkgs, 
    hyprland, 
    home-manager, 
    catppuccin, 
    ... 
  }: 
  let
    mkHost = hostName: { system ? "x86_64-linux" }:
      nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { inherit inputs; };
        modules = [
          { networking.hostName = hostName; }
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              extraSpecialArgs = { inherit catppuccin; };
            };
          }
          ./modules/shared/defaults.nix
          ./modules/shared/user.nix
          ./modules/desktop/default.nix
          ./modules/gaming/default.nix
          ./modules/dev/default.nix
          ./hosts/${hostName}/default.nix
        ];
      };
  in {
    nixosConfigurations = {
      e15 = mkHost "e15" {};
      legioni5 = mkHost "legioni5" {};
    };
  };
}
