{
  config,
  pkgs,
  ...
}: {
  boot.loader = {
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot";
    };

    grub = {
      devices = ["nodev"];
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
}
