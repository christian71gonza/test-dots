{
  description = "test config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs, ... } @ inputs: let
    user = import ./user;
    pkgs = nixpkgs.legacyPackages.${builtins.currentSystem};

    inherit (self) outputs;
  in {
    packages = user.packages pkgs;

    formatter = pkgs.alejandra;

    nixosModules = {
      user = user.module;
    };

    nixosConfigurations = {
      nixos = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs outputs; };
        modules = [ ./system/default.nix ];
      };
    };
  };
}
