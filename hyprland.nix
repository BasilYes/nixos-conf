{ pkgs, ... }:

{
	programs.hyprland = {
		enable = true;
		xwayland.enable = true;
	};

	environment.sessionVariables = {
		# Hint electron apps to use wayland
		NIXOS_OZONE_WL = "1";
	};

	xdg.portal.extraPortals	= [ pkgs.xdg-desktop-portal-hyprland ];

  environment.systemPackages = with pkgs; [
    gnome.nautilus
		(waybar.overrideAttrs (oldAttrs: {
				mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
			})
		)
		dunst
		libnotify
		swww
		kitty
		wofi
		grim
		slurp
  ];
}
