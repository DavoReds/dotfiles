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

    stylix = {
      url = "github:danth/stylix";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        home-manager.follows = "home-manager";
      };
    };
  };

  outputs = {
    self,
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
          ./hosts/dalinux/configuration.nix
          ./nixosModules
          inputs.disko.nixosModules.default
          inputs.stylix.nixosModules.stylix
        ];
      };

      ferroserver = nixpkgs.lib.nixosSystem {
        inherit system;

        specialArgs = {inherit inputs;};
        modules = [
          ./hosts/ferroserver/configuration.nix
          ./nixosModules
          inputs.stylix.nixosModules.stylix
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
          inputs.catppuccin.homeManagerModules.catppuccin
          inputs.stylix.homeManagerModules.stylix
        ];
      };

      jofero = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        extraSpecialArgs = {inherit inputs;};
        modules = [
          ./homes/jofero/home.nix
          ./homeModules
          inputs.catppuccin.homeManagerModules.catppuccin
          inputs.stylix.homeManagerModules.stylix
        ];
      };

      samuel = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        extraSpecialArgs = {inherit inputs;};
        modules = [
          ./homes/samuel/home.nix
          ./homeModules
          inputs.catppuccin.homeManagerModules.catppuccin
          inputs.stylix.homeManagerModules.stylix
        ];
      };
    };
  };
}
