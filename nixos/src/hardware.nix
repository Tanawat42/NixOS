{
  pkgs,
  # lib,
  config,
  ...
} : {
  hardware.enableAllFirmware = true;
  hardware.cpu.intel.updateMicrocode = true;
  hardware.intel-gpu-tools.enable = true;
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
    extraPackages = with pkgs; [
      mesa
      intel-vaapi-driver
      libvdpau-va-gl
      intel-ocl
      intel-compute-runtime
    ];
  };
}
