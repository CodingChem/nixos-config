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
    oxwm = {
      url = "github:tonybanters/oxwm";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = inputs @ { 
    self, 
      nixpkgs, 
      hyprland, 
      home-manager, 
      catppuccin, 
      oxwm,
      ... 
  }: {
    nixosConfigurations.e15 = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs; };
      modules = [
        ./hosts/e15/default.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.extraSpecialArgs = { inherit catppuccin; };
          }
      ];
    };
    nixosConfigurations.legioni5 = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs; };
      modules = [
        ./hosts/legioni5/default.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.extraSpecialArgs = { inherit catppuccin; };
          }
      oxwm.nixosModules.default
      {
        services.xserver = {
          enable = true;
          windowManager.oxwm.enable = true;
        };
      }
      ];
    };
  };
}
