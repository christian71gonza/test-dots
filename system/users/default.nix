{
  config,
  pkgs,
  ...
}: {
  # TODO: Configure your system-wide user settings (groups, etc), add more users as needed.
  users.users = {
    # FIXME: Replace with your username
    user = {
      isNormalUser = true;

      # openssh.authorizedKeys.keys = [
      #   # TODO: Add your SSH public key(s) here, if you plan on using SSH to connect
      # ];

      # TODO: Be sure to add any other groups you need (such as networkmanager, audio, docker, etc)
      extraGroups = ["wheel" "networkmanager"];
    };
  };

  environment.variables = {
    STARSHIP_LOG = "error";
  };
}
