{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./packages.nix
    ./shell
    ./git
  ];
}
