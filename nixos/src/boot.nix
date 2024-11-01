{
  lib,
  pkgs,
  config,
  ...
} :
{
  boot.kernelParams = [ "i915.modeset=1" ];
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.supportedFilesystems = [ "ntfs" "btrfs" ];
}
