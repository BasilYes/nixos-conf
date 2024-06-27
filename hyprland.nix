{ pkgs, lib, ... }:

{
	programs.hyprland = {
		enable = true;
		xwayland.enable = true;
	};

	environment.sessionVariables = {
		# Hint electron apps to use wayland
		# NIXOS_OZONE_WL = "1";
	};

	xdg.portal.extraPortals	= lib.mkForce [
    pkgs.xdg-desktop-portal-gtk # For both
    pkgs.xdg-desktop-portal-hyprland # For Hyprland
    pkgs.xdg-desktop-portal-gnome # For GNOME
  ];

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
		kitty
		rofi-wayland
		grim
		glib
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
		wttrbar
		brillo
		gnome.gnome-calculator
		gnome.gnome-weather
		gnome.gnome-calendar
  ];
}
