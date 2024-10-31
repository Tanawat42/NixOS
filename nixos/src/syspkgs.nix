{
	pkgs,
  config,
	...
} : {
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
			themeConfig.General = {
				background = "${config.stylix.image}";
				backgroundMode = "none";
			};
		})
	];
}
