{
  lib,
  pkgs,
  config,
  ...
} :
{
  # boot.kernelParams = [ ];
  boot.supportedFilesystems = [ "ntfs" "btrfs" ];
  boot.loader.grub.device = "/dev/vda";
}
