{ config, pkgs, ... }: {
  imports = [
    ./net
    ./disks
    ./boot
    ./audio
    ./users
    ./wayland
    ./nix
    ./configuration.nix
  ];

  time = {
    timeZone = "America/Montevideo";
    hardwareClockInLocalTime = true;
  };
  system.stateVersion = "23.05";
}
