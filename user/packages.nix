{
  config,
  pkgs,
  ...
}: {
  programs = {
    firefox.enable = true;
    hyprland.enable = true;
    waybar.enable = true;
  };

  environment.systemPackages = with pkgs; [
    (import ./alacritty.nix {inherit pkgs;})
    kitty
    hyprpaper
    vim
    volantes-cursors
    #    alacritty
    neovim
    wl-clipboard
    gcc
    ripgrep
    pfetch
    htop
    alejandra
  ];
}
