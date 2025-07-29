{
  description = "MrAngames' NixOS + Home Manager config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nixos-boot.url = "github:Melkor333/nixos-boot";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, home-manager, nixos-boot, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          config.allowUnfree = true;  # если нужно
        };
      in {
        nixosConfigurations = {
          nixos = pkgs.lib.nixosSystem {
            system = system;
            modules = [
              nixos-boot.nixosModules.default
              ./hosts/nixos.nix
              ./hardware/hardware-configuration.nix

              # Включаем Home Manager как модуль NixOS
              home-manager.nixosModules.home-manager

              # Конфигурация Home Manager пользователя mrangames
              {
                home-manager.useGlobalPkgs = true;
                home-manager.useUserPackages = true;
                home-manager.users.mrangames = import ./home/home.nix;
              }
            ];
            configuration = {};
          };
        };

        # Опционально — отдельная конфигурация Home Manager для пользователя:
        homeConfigurations = {
          mrangames = home-manager.lib.homeManagerConfiguration {
            pkgs = pkgs;
            system = system;
            username = "mrangames";
            homeDirectory = "/home/mrangames";
            configuration = import ./home/home.nix;
          };
        };
      }
    );
}

