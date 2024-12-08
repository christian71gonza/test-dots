{
  config,
  pkgs,
  ...
}: {
  programs.starship = {
    enable = true;
    presets = [
      "plain-text-symbols"
    ];
    settings = {
      add_newline = false;
      scan_timeout = 5;
      character = {
        error_symbol = "[>](bold red)";
        success_symbol = "[>](bold green)";
        vicmd_symbol = "[>](bold yellow)";
        format = "$symbol ";
      };
      line_break.disabled = false;
      hostname = {
        ssh_only = true;
        format = "[$hostname](bold blue) ";
        disabled = false;
      };
    };
  };
}
