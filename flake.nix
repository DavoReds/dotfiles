{
  description = "Configurations for Dalia's systems";

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

    stylix = {
      url = "github:danth/stylix";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        home-manager.follows = "home-manager";
      };
    };
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
          inputs.stylix.nixosModules.stylix
        ];
      };

      ferroserver = nixpkgs.lib.nixosSystem {
        inherit system;

        specialArgs = {inherit inputs;};
        modules = [
          ./nix/hosts/ferroserver/configuration.nix
          ./nix/nixosModules
          inputs.stylix.nixosModules.stylix
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
          inputs.stylix.homeManagerModules.stylix
        ];
      };

      jofero = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        extraSpecialArgs = {inherit inputs;};
        modules = [
          ./nix/homes/jofero/home.nix
          ./nix/homeModules
          inputs.catppuccin.homeManagerModules.catppuccin
          inputs.stylix.homeManagerModules.stylix
        ];
      };

      samuel = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        extraSpecialArgs = {inherit inputs;};
        modules = [
          ./nix/homes/samuel/home.nix
          ./nix/homeModules
          inputs.catppuccin.homeManagerModules.catppuccin
          inputs.stylix.homeManagerModules.stylix
        ];
      };
    };
  };
}
