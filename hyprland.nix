{ pkgs, ... }:

{
	programs.hyprland = {
		enable = true;
		xwayland.enable = true;
	};

	environment.sessionVariables = {
		# Hint electron apps to use wayland
		# NIXOS_OZONE_WL = "1";
	};

	xdg.portal.extraPortals	= [
		pkgs.xdg-desktop-portal-hyprland
		# pkgs.xdg-desktop-portal-gtk
	];

	services.udisks2.enable = true;
	services.blueman.enable = true;
	services.gvfs.enable = true;

	programs.evolution.enable = true;

  environment.systemPackages = with pkgs; [
    gnome.nautilus
		(waybar.overrideAttrs (oldAttrs: {
				mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
			})
		)
		swaynotificationcenter
		libnotify
		kitty
		rofi-wayland
		grim
		slurp
		jq
		wl-clipboard
		killall
		udiskie
		pavucontrol
		pamixer
		playerctl
		hyprpicker
		networkmanagerapplet
		brillo
		gnome.gnome-calculator
		gnome.gnome-calendar
  ];
}
