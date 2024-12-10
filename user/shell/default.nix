{
  config,
  pkgs,
  ...
}: {
  users.defaultUserShell = pkgs.zsh;
  programs.zsh = {
    shellAliases = {
      ".." = "cd ..";
      "..." = "cd ../..";
      "...." = "cd ../../..";
      "--" = "cd -";
      "path" = "cd .dotfiles";
      "q" = "exit";
      "clr" = "clear";
      "rm" = "rm -r";
      "l" = "ls";
      "g" = "git";
      "ga" = "git add .";
      "gco" = "git commit";
      "gu" = "git push";
      "n" = "nix";
      "gc" = "nix-collect-garbage";
      "gcd" = "nix-collect-garbage -d";
      "sync" = "sudo nixos-rebuild switch --flake . --show-trace";
      "upd" = "nix flake update";
      "v" = "nvim";
    };
    interactiveShellInit = "source ${pkgs.zsh-nix-shell}/share/zsh-nix-shell/nix-shell.plugin.zsh";
    enable = true;
    syntaxHighlighting.enable = true;
    autosuggestions.enable = true;
    enableCompletion = true;
  };

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
