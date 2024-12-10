{
  config,
  pkgs,
  inputs,
  ...
}: {
  programs = {
    firefox.enable = true;
    hyprland.enable = true;
    waybar.enable = true;
    tmux.enable = true;
  };

  environment.systemPackages = with pkgs; [
    (import ./alacritty.nix {inherit pkgs;})
    kitty
    hyprpaper
    vim
    volantes-cursors
    #    alacritty
    neovim
    zsh-nix-shell
    wl-clipboard
    gcc
    ripgrep
    pfetch
    htop
    alejandra
  ];
}
