{
  pkgs,
  ...
} : {
  services.xserver = {
    enable = true;
	excludePackages = with pkgs; [
		xterm
	];
    videoDrivers = [ "i915" ];
    xkb = {
      variant = "";
      layout = "us";
    };
  };
  services.displayManager = {
	  sddm = {
   		enable = true;
   		theme = "sddm_theme_qt6";
   		wayland.enable = true;
  	};
  };
  services.desktopManager.plasma6 = {
    enable = true;
  };
  services.usbmuxd = {
    enable = true;
    package = pkgs.usbmuxd2;
  };
  services.pipewire = {
    enable = true;
    wireplumber.enable = true;
    alsa.enable = true;
    pulse.enable = true;
	jack.enable = true;
  };
  services.udisks2.enable = true;
  services.gvfs.enable = true;
  services.fstrim.enable = true;
  services.udev.packages = with pkgs; [
    android-udev-rules
    maschine-mikro-mk3-driver
  ];
  services.udev.extraRules = ''
    KERNEL=="uinput", MODE="0660", GROUP="uinput", OPTIONS+="static_node=uinput"
    SUBSYSTEM=="usbmon", GROUP="wireshark", MODE="0640"
  '';
  services.openssh = {
    enable = true;
    ports = [ 22 ];
    settings = {
      PermitRootLogin = "no";
      # PasswordAuthentication = false;
    };
  };
  services.dbus.packages = with pkgs; [ libsForQt5.kpmcore ];
  services.fwupd.enable = true;
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    nssmdns6 = true;
    publish = {
      enable = true;
      addresses = true;
      workstation = true;
    };
  };
}
