{
  inputs.nixos-boot.url = "github:Melkor333/nixos-boot";
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";

  outputs = { self, nixpkgs, nixos-boot, ... }:
  {
    nixosConfigurations = {
      "nixos" = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          nixos-boot.nixosModules.default
          ./configuration.nix
        ];
      };
    };
  };
}

