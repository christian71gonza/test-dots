{ pkgs, ... }

pkgs.symlinkJoin {
  name = "alacritty";
  paths = [ pkgs.alacritty ];
  buildInputs = [ pkgs.makeWrapper ];
  postBuild = ''
    wrapProgram $out/bin/alacritty \
      --add-flags "--config-file=" \
      --add-flags "${./alacritty.toml}"
  '';
}
