{ pkgs, lib, extraOptions, ... }:

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
    # pkgs.xdg-desktop-portal-gnome
  ]
	++ lib.optionals (!(extraOptions.gnome or false)) [ pkgs.xdg-desktop-portal-gtk ];

	services.udisks2.enable = true;
	services.blueman.enable = true;
	services.gvfs.enable = true;
	services.gnome.gnome-online-accounts.enable = true;
	services.displayManager.defaultSession = "hyprland";
	programs.evolution.enable = true;

  environment.systemPackages = with pkgs; [
    gnome.nautilus
		(waybar.overrideAttrs (oldAttrs: {
				mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
			})
		)
		swaynotificationcenter
		libnotify
		loupe
		kitty
		rofi-wayland
		glib
		slurp
		grim
		swappy
		# hyprshot
		jq
		wl-clipboard
		killall
		udiskie
		pavucontrol
		pamixer
		playerctl
		hyprpicker
		networkmanagerapplet
		wttrbar
		brillo
		gnome.gnome-calculator
		gnome.gnome-weather
		gnome.gnome-calendar
  ];
}
