{ config, pkgs, ... }: {

programs = {
  firefox.enable = true;
  hyprland.enable = true;
  waybar.enable = true;
};

  environment.systemPackages = with pkgs; [
    kitty
    hyprpaper
    vim
    alacritty
    pfetch
    htop
  ];

}
