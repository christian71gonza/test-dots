# This is your system's configuration file.
# Use this to configure your system environment (it replaces /etc/nixos/configuration.nix)

{ inputs, lib, config, pkgs, ... }: 

let
  # Import the custom Alacritty wrapper
  alacrittyWrapper = import ./alacritty-wrapper.nix {
    inherit (pkgs) lib runCommand makeWrapper alacritty formats;
  };
in
{
  # Imports other modules (including hardware configuration)
  imports = [
    ./hardware-configuration.nix
    # other imports can go here
  ];

  nixpkgs = {
    # You can add overlays here
    overlays = [
      # If you want to use overlays exported from other flakes:
      # neovim-nightly-overlay.overlays.default

      # Or define it inline, for example:
      # (final: prev: {
      #   hi = final.hello.overrideAttrs (oldAttrs: {
      #     patches = [ ./change-hello-to-hi.patch ];
      #   });
      # })
    ];

    # Configure your nixpkgs instance
    config = {
      # Disable if you don't want unfree packages
      allowUnfree = true;
    };
  };

  nix = let
    flakeInputs = lib.filterAttrs (_: lib.isType "flake") inputs;
  in {
    settings = {
      # Enable flakes and new 'nix' command
      experimental-features = "nix-command flakes";

      # Opinionated: disable global registry
      flake-registry = "";

      # Workaround for https://github.com/NixOS/nix/issues/9574
      nix-path = config.nix.nixPath;
    };

    # Opinionated: disable channels
    channel.enable = false;

    # Opinionated: make flake registry and nix path match flake inputs
    registry = lib.mapAttrs (_: flake: { inherit flake; }) flakeInputs;
    nixPath = lib.mapAttrsToList (n: _: "${n}=flake:${n}") flakeInputs;
  };

  # FIXME: Add the rest of your current configuration

  programs.firefox.enable = true;
  programs.waybar.enable = true;
  programs.hyprland.enable = true;

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  boot.loader = {
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot";
    };

    grub = {
      devices = [ "nodev" ];
      efiSupport = true;
      enable = true;

      extraEntries = ''
        menuentry "Win 11" {
          insmod part_gpt
          insmod fat
          insmod search_fs_uuid
          insmod chain
          search --fs-uuid --set=root F2FA-6537
          chainloader /EFI/Microsoft/Boot/bootmgfw.efi
        }
      '';
    };
  };

  networking.networkmanager.enable = true;

  time = {
    timeZone = "America/Montevideo";
    hardwareClockInLocalTime = true;
  };

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

  # Define system packages
  environment.systemPackages = with pkgs; [
    alacrittyWrapper  # Alacritty wrapper will be available here
  ];

  # TODO: Set your hostname
  networking.hostName = "nixos";

  # TODO: Configure your system-wide user settings (groups, etc), add more users as needed.
  users.users = {
    # FIXME: Replace with your username
    user = {
      isNormalUser = true;

      # openssh.authorizedKeys.keys = [
      #   # TODO: Add your SSH public key(s) here, if you plan on using SSH to connect
      # ];

      # TODO: Be sure to add any other groups you need (such as networkmanager, audio, docker, etc)
      extraGroups = [ "wheel" "networkmanager" ];

      packages = with pkgs; [
        kitty
        hyprpaper
        vim
#        alacritty
	pfetch
        htop
      ];
    };
  };

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "23.05";
}
