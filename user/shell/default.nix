{
  config,
  pkgs,
  ...
}: {
  users.defaultUserShell = pkgs.zsh;
  programs.zsh = {
    enable = true;
    syntaxHighlighting.enable = true;
    autosuggestions.enable = true;
    enableCompletion = true;
  };

  programs.starship = {
    enable = true;
    settings = {
      add_newline = false;
      scan_timeout = 5;
      character = {
        error_symbol = "[ ](bold red)";
        success_symbol = "[ ](bold green)";
        vicmd_symbol = "[ ](bold yellow)";
        format = "$symbol [~](bold cyan) [❯](bold red)[❯](bold yellow)[❯](bold green) ";
      };
      git_commit = {commit_hash_length = 4;};
      line_break.disabled = false;
      lua.symbol = "[](blue) ";
      hostname = {
        ssh_only = true;
        format = "[$hostname](bold blue) ";
        disabled = false;
      };
    };
  };
}
