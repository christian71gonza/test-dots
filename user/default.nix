rec {
  packages = pkgs: let
    inherit (pkgs) callPackage;
  in {
    # No package definitions
  };

  module = {pkgs, ...}: {
    config = {
      environment.systemPackages = builtins.attrValues (packages pkgs);
    };
    imports = [
      ./packages.nix
    ];
  };
}
