# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
{
	# inputs,
	outputs,
	# lib,
	config,
	pkgs,
	...
}: {
	# You can import other home-manager modules here
	imports = [
		# If you want to use modules your own flake exports (from modules/home-manager):
		# outputs.homeManagerModules.example

		# Or modules exported from other flakes (such as nix-colors):
		# inputs.nix-colors.homeManagerModules.default

		# You can also split up your configuration and import pieces of it here:
		# ./nvim.nix
		./src/stylix.nix
		./src/stylix-home.nix
		# ./src/hyprland.nix
		./src/programs.nix
		./src/systemd.nix
		./src/environment.nix
	];

	nixpkgs = {
		# You can add overlays here
		overlays = [
			# Add overlays your own flake exports (from overlays and pkgs dir):
			outputs.overlays.additions
			outputs.overlays.modifications
			outputs.overlays.unstable-packages

			# You can also add overlays exported from other flakes:
			# neovim-nightly-overlay.overlays.default

			# Or define it inline, for example:
			# (final: prev: {
			#		hi = final.hello.overrideAttrs (oldAttrs: {
			#			patches = [ ./change-hello-to-hi.patch ];
			#		});
			# })
		];
		# Configure your nixpkgs instance
		config = {
			# Disable if you don't want unfree packages
			allowUnfree = true;
		};
	};

	# TODO: Set your username
	home = {
		username = "bocal";
		homeDirectory = "/home/bocal";
	};

	# Add stuff for your user as you see fit:

	fonts.fontconfig.enable = true;

	home.packages = with pkgs; [
		# Util
		fastfetch
		# waybar
		# rofi-wayland
		# rofi-bluetooth
		# hyprpaper
		xwaylandvideobridge
		btop
		# hyprnome ???
		# hyprpicker
		# hyprshot
		# wleave
		wl-clipboard
		cliphist
		# File management
		dolphin
		ark
		# Editors
		# Internet - Media
		vesktop
		firefox
		irssi-v123
		# Fonts
		(nerdfonts.override {
			fonts = [ "Hack" "FiraCode" ];
		})
		tlwg
		noto-fonts-cjk
		noto-fonts-emoji
	];

	home.file = {
		"${config.home.homeDirectory}/.face" = {
			source = "${../assets/user/profile}";
		};
	};

	gtk = {
		enable = true;
		iconTheme = {
			name = "Flat-Remix-Cyan-Dark";
			package = pkgs.flat-remix-icon-theme;
		};
	};

	# https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
	home.stateVersion = "24.05";
}
