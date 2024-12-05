{ config, pkgs, ... }: {
  imports = [
    ./net
    ./disks
    ./boot
    ./audio
    ./users
    ./wayland
    ./nix
  ];

  networking.hostName = "nixos";

  time = {
    timeZone = "America/Montevideo";
    hardwareClockInLocalTime = true;
  };
  system.stateVersion = "23.05";
}
