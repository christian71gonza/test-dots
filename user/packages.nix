{ config, pkgs, ... }: {


  environment.systemPackages = with pkgs; [
    kitty
    hyprpaper
    vim
    alacritty
    pfetch
    htop
  ];

}
