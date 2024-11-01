{
	pkgs,
  config,
	...
} : {
	environment.sessionVariables = {
		LIBVA_DRIVER_NAME = "i965";
	};
	environment.systemPackages = with pkgs; [
		# home manager
		home-manager
		# System utils
		tree
		gzip
		unzip
		brightnessctl
		pulseaudio
		direnv
		aha
		fwupd-efi
		pciutils
		clinfo
		glxinfo
		vulkan-tools
		wayland-utils
		# driver
		maschine-mikro-mk3-driver
		spice-vdagent
		# Manuals
		man-pages
		man-pages-posix
		# Build tools
		gnumake
		cmake
		meson
		cargo
		# Debuggers
		valgrind
		gdb
		lldb
		# Language servers
		clang
		clang-tools
		nixd
		# Common packags
		git
		# Programming Language
		python3
		nodejs
		# Default minimal text editor
		nano
		# Custom packages
		(sddm-theme.override {
			variants = [ "qt6" ];
			themeConfig.General = {
				# background = "${config.stylix.image}";
				# backgroundMode = "none";
				ScreenWidth="1920";
				ScreenHeight="1080";
				Font="Open Sans";
				KeyboardSize="0.4";
				RoundCorners="20";
				HourFormat="HH:mm";
				DateFormat="dddd d MMMM";
				HeaderText="-- Testing Machine 42 --";
				DimBackground="0.0";
				CropBackground="true";
				Background = "${config.stylix.image}";
				BackgroundHorizontalAlignment="center";
			};
		})
	];
}
