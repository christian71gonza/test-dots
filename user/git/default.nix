{
  config,
  pkgs,
  ...
}: {
  programs.git = {
    enable = true;
    config = {
      init.defaultBranch = "main";
      safe.directory = "/home/user/.dotfiles";
      user = {
        email = "christian71gonza.les.4.878@gmail.com";
        name = "christian71gonza";
      };
    };
  };
}
