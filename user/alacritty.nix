{pkgs, ...}: let
  config = pkgs.writeText "alacritty.toml" ''
    [window]
    padding.x = 20
    padding.y = 20
    opacity = 1

    [font]
    size = 12.0

    [font.bold]
    family = "JetBrainsMono Nerd Font"
    style = "Bold"

    [font.bold_italic]
    family = "JetBrainsMono Nerd Font"
    style = "Bold Italic"

    [font.italic]
    family = "JetBrainsMono Nerd Font"
    style = "Italic"

    [font.normal]
    family = "JetBrainsMono Nerd Font"
    style = "Regular"

    [colors.bright]
    black = "#151720"
    blue = "#86aaec"
    cyan = "#93cee9"
    green = "#90ceaa"
    magenta = "#c296eb"
    red = "#dd6777"
    white = "#cbced3"
    yellow = "#ecd3a0"

    [colors.cursor]
    cursor = "#a5b6cf"
    text = "CellForeground"

    [colors.normal]
    black = "#1c1e27"
    blue = "#8baff1"
    cyan = "#98d3ee"
    green = "#95d3af"
    magenta = "#c79bf0"
    red = "#e26c7c"
    white = "#d0d3d8"
    yellow = "#f1d8a5"

    [colors.primary]
    background = "#101419"
    foreground = "#a5b6cf"
  '';
in
  pkgs.symlinkJoin {
    name = "alacritty-wrapped";
    paths = [pkgs.alacritty];
    buildInputs = [pkgs.makeWrapper];
    postBuild = ''
      wrapProgram $out/bin/alacritty --add-flags "--config-file=${config}"
    '';
  }
