{
  pkgs,
  ...
}: let

  config = pkgs.writeText "alacritty.toml" (pkgs.lib.generators.toTOMLT {} {
     window = {
    padding = {
      x = 20;
      y = 20;
    };
  };

  font = {
    size = 12.0;

    bold = {
      family = "monospace";
      style = "Bold";
    };

    bold_italic = {
      family = "monospace";
      style = "Bold Italic";
    };

    italic = {
      family = "monospace";
      style = "Italic";
    };

    normal = {
      family = "JetBrainsMono Nerd Font";
      style = "Regular";
    };
  };

  colors = {
    bright = {
      black = "#151720";
      blue = "#86aaec";
      cyan = "#93cee9";
      green = "#90ceaa";
      magenta = "#c296eb";
      red = "#dd6777";
      white = "#cbced3";
      yellow = "#ecd3a0";
    };

    cursor = {
      cursor = "#a5b6cf";
      text = "CellForeground";
    };

    normal = {
      black = "#1c1e27";
      blue = "#8baff1";
      cyan = "#98d3ee";
      green = "#95d3af";
      magenta = "#c79bf0";
      red = "#e26c7c";
      white = "#d0d3d8";
      yellow = "#f1d8a5";
    };

    primary = {
      background = "#0d0f18";
      foreground = "#a5b6cf";
    };
  }; 
  });
in
  pkgs.symlinkJoin {
    name = "alacritty-wrapped";
    paths = [pkgs.foot];
    buildInputs = [pkgs.makeWrapper];
    postBuild = ''
      wrapProgram $out/bin/alacritty --add-flags "--config-file=${config}"
    '';
  }
