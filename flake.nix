{
  description = "Configurations for Dalia's systems";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nbfc-linux = {
      url = "github:nbfc-linux/nbfc-linux/530f0d08017be02569d31a642c2b0269af71b226";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    catppuccin.url = "github:catppuccin/nix";
  };

  outputs = {
    nixpkgs,
    home-manager,
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
          ./nix/hosts/dalinux/configuration.nix
          ./nix/nixosModules
          inputs.disko.nixosModules.default
        ];
      };

      ferroserver = nixpkgs.lib.nixosSystem {
        inherit system;

        specialArgs = {inherit inputs;};
        modules = [
          ./nix/hosts/ferroserver/configuration.nix
          ./nix/nixosModules
        ];
      };
    };

    homeConfigurations = {
      dalia = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        extraSpecialArgs = {inherit inputs;};
        modules = [
          ./nix/homes/dalia/home.nix
          ./nix/homeModules
          inputs.catppuccin.homeManagerModules.catppuccin
        ];
      };

      jofero = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        extraSpecialArgs = {inherit inputs;};
        modules = [
          ./nix/homes/jofero/home.nix
          ./nix/homeModules
          inputs.catppuccin.homeManagerModules.catppuccin
        ];
      };

      samuel = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        extraSpecialArgs = {inherit inputs;};
        modules = [
          ./nix/homes/samuel/home.nix
          ./nix/homeModules
          inputs.catppuccin.homeManagerModules.catppuccin
        ];
      };
    };
  };
}
