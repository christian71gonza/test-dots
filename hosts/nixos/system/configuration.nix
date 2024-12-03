# This is your system's configuration file.
# Use this to configure your system environment (it replaces /etc/nixos/configuration.nix)

{
  config,
  pkgs,
  ...
}: {

  # FIXME: Add the rest of your current configuration

  programs.firefox.enable = true;
  programs.waybar.enable = true;
  programs.hyprland.enable = true;

  users.defaultUserShell = pkgs.zsh;
  programs.zsh = {
    enable = true;
    syntaxHighlighting.enable = true;
    autosuggestions.enable = true;
    enableCompletion = true;
  };

  programs.git = {
    enable = true;
    config = {
      init.defaultBranch = "main";
      safe.directory = "/home/user/.nix-dots";
      user = {
        email = "christian71gonza.les.4.878@gmail.com";
        name = "christian71gonza";
      };
    };
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

  # TODO: Set your hostname
  networking.hostName = "nixos";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "23.05";
}
