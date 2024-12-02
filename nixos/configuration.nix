{ inputs, lib, config, pkgs, ... }: 

let
  alacrittyWrapper = import ./alacritty-wrapper.nix {
    inherit (pkgs) lib makeWrapper alacritty writeText;
  };
in
{
  # Imports other modules (including hardware configuration)
  imports = [
    ./hardware-configuration.nix
  ];

  nixpkgs = {
    overlays = [];
    config.allowUnfree = true;
  };

  nix = let
    flakeInputs = lib.filterAttrs (_: lib.isType "flake") inputs;
  in {
    settings.experimental-features = "nix-command flakes";
    channel.enable = false;
    registry = lib.mapAttrs (_: flake: { inherit flake; }) flakeInputs;
    nixPath = lib.mapAttrsToList (n: _: "${n}=flake:${n}") flakeInputs;
  };

  # Programs and system packages
  programs = {
    firefox.enable = true;
    waybar.enable = true;
    hyprland.enable = true;

    zsh = {
      enable = true;
      syntaxHighlighting.enable = true;
      autosuggestions.enable = true;
      enableCompletion = true;
    };

    git = {
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

    starship = {
      enable = true;
      settings = {
        add_newline = false;
        scan_timeout = 5;
        character = {
          error_symbol = "[ ](bold red)";
          success_symbol = "[ ](bold green)";
          vicmd_symbol = "[ ](bold yellow)";
          format = "$symbol [~](bold cyan) [❯](bold red)[❯](bold yellow)[❯](bold green)";
        };
        git_commit.commit_hash_length = 4;
        line_break.disabled = false;
        lua.symbol = "[](blue)";
        hostname = {
          ssh_only = true;
          format = "[$hostname](bold blue)";
          disabled = false;
        };
      };
    };
  };

  # Graphics settings
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  # Boot settings
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

  networking = {
    networkmanager.enable = true;
    hostName = "nixos";
  };

  time = {
    timeZone = "America/Montevideo";
    hardwareClockInLocalTime = true;
  };

  users = {
    defaultUserShell = pkgs.zsh;

    users = {
      user = {
        isNormalUser = true;
        extraGroups = [ "wheel" "networkmanager" ];

        packages = with pkgs; [
          kitty
          hyprpaper
          vim
          pfetch
          htop
        ];
      };
    };
  };

  # System packages
  environment.systemPackages = with pkgs; [
    alacrittyWrapper  # Add Alacritty wrapper here
  ];

  system.stateVersion = "23.05";
}
