{
  config,
  pkgs,
  inputs,
  ...
}: {
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
