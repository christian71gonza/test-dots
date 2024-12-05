{
  pkgs,
  ...
}: let

  config = pkgs.writeText "alacritty.toml" ''
    [window]
    opacity = 0.9
    dimensions = { columns = 80, lines = 24 }
    
    [font]
    size = 12
    
    [colors]
    [colors.primary]
    background = "#282828"
    foreground = "#ebdbb2"
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
