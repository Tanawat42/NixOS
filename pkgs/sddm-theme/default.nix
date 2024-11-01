{
  lib,
  formats,
  stdenvNoCC,
  fetchFromGitHub,
  qt6,
  libsForQt5,
  variants ? [ "qt5" "qt6" ],
  /*
    An example of how you can override the background on the NixOS logo

      environment.systemPackages = [
        (pkgs.where-is-my-sddm-theme.override {
          themeConfig.General = {
            background = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
            backgroundMode = "none";
          };
        })
      ];
  */
  themeConfig ? null,
}:

let
  user-cfg = (formats.ini { }).generate "theme.conf" themeConfig;
  validVariants = [
    "qt5"
    "qt6"
  ];
in

lib.checkListOfEnum "sddm_theme: variant" validVariants variants

  stdenvNoCC.mkDerivation
  # (finalAttrs: {
  #   pname = "sddm_theme";
  #   version = "6726b5e";

  #   src = fetchFromGitHub {
  #     owner = "totoro-ghost";
  #     repo = "sddm-astronaut";
  #     # rev = "refs/tags/v${finalAttrs.version}";
	#   rev = "6726b5e";
	#   hash = "sha256-j8pJvBml2LWxXNw1e/cSVXV+6w+K1lahv0uK1B9OYn0=";
  #   };

  (finalAttrs: {
    pname = "sddm_theme";
    version = "8993670";

    src = fetchFromGitHub {
      owner = "Keyitdev";
      repo = "sddm-astronaut-theme";
      # rev = "refs/tags/v${finalAttrs.version}";
      rev = "8993670";
      hash = "sha256-uEZX5J9uhPKakVFnjfzxjOvrvk4F4CNXthkIYroITl4=";
    };

    propagatedUserEnvPkgs =
      [ ]
      ++ lib.optionals (lib.elem "qt5" variants) [ libsForQt5.qtgraphicaleffects ]
      ++ lib.optionals (lib.elem "qt6" variants) [
        qt6.qt5compat
        qt6.qtsvg
      ];

	installPhase =
	      lib.optionalString (lib.elem "qt5" variants) (
        ''
		      mkdir -p $out/share/sddm/themes/sddm_theme_qt5
          cp -r * $out/share/sddm/themes/sddm_theme_qt5
        ''
        + lib.optionalString (lib.isAttrs themeConfig) ''
          # ln -sf ${user-cfg} $out/share/sddm/themes/sddm_theme_qt5/theme.conf.user
          ln -sf ${user-cfg} $out/share/sddm/themes/sddm_theme_qt5/Themes/theme1.conf
        ''
      ) + lib.optionalString (lib.elem "qt6" variants) (
        ''
		      mkdir -p $out/share/sddm/themes/sddm_theme_qt6
          cp -r * $out/share/sddm/themes/sddm_theme_qt6
        ''
        + lib.optionalString (lib.isAttrs themeConfig) ''
          # ln -sf ${user-cfg} $out/share/sddm/themes/sddm_theme_qt6/theme.conf.user
          ln -sf ${user-cfg} $out/share/sddm/themes/sddm_theme_qt6/Themes/theme1.conf
        ''
      );

    meta = {
      description = "A theme for the SDDM login manager made specifically for the Lubuntu distribution, but can also serve any other, that uses SDDM.";
      homepage = "https://github.com/totoro-ghost/sddm-astronaut.git";
      license = lib.licenses.lgpl3Only;
      platforms = lib.platforms.linux;
      maintainers = with lib.maintainers; [ name-snrl ];
    };
})
