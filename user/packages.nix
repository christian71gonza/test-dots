{pkgs, ...}: let
  inherit (builtins) attrValues;
in {
  environment.systemPackages = attrValues {
    inherit
      (pkgs)
      kitty
      hyprpaper
      vim
      alacritty
      pfetch
      htop
      ;
  };
}
