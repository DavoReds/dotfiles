{
  description = "All of Dalia's configurations";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nbfc-linux = {
      url = "github:nbfc-linux/nbfc-linux";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    catppuccin.url = "github:catppuccin/nix";
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    disko,
    catppuccin,
    ...
  } @ inputs: let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
  in {
    nixosConfigurations = {
      dalinux = nixpkgs.lib.nixosSystem {
        inherit system;

        specialArgs = {inherit inputs;};
        modules = [
          ./hosts/dalinux/configuration.nix
          ./nixosModules
          disko.nixosModules.default
          catppuccin.nixosModules.catppuccin
        ];
      };

      ferroserver = nixpkgs.lib.nixosSystem {
        inherit system;

        specialArgs = {inherit inputs;};
        modules = [
          ./hosts/ferroserver/configuration.nix
          ./nixosModules
          catppuccin.nixosModules.catppuccin
        ];
      };
    };

    homeConfigurations = {
      dalia = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        extraSpecialArgs = {inherit inputs;};
        modules = [
          ./homes/dalia/home.nix
          ./homeModules
          catppuccin.homeManagerModules.catppuccin
        ];
      };

      jofero = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        extraSpecialArgs = {inherit inputs;};
        modules = [
          ./homes/jofero/home.nix
          ./homeModules
          catppuccin.homeManagerModules.catppuccin
        ];
      };

      samuel = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        extraSpecialArgs = {inherit inputs;};
        modules = [
          ./homes/samuel/home.nix
          ./homeModules
          catppuccin.homeManagerModules.catppuccin
        ];
      };
    };
  };
}
