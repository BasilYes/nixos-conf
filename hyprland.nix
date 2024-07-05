{ pkgs, lib, extraOptions, ... }:

{
	programs.hyprland = {
		enable = true;
		xwayland.enable = true;
	};

	environment.sessionVariables = {
		# Hint electron apps to use wayland
		# NIXOS_OZONE_WL = "1";
		${if (extraOptions.forceWayland or false) then "NIXOS_OZONE_WL" else null} = "1";
	};
	# ++ lib.attrsets.optionalAttrs (extraOptions.forceWayland or false) {  NIXOS_OZONE_WL = "1"; };

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
	services.gnome.evolution-data-server.enable = true;

	environment.sessionVariables.GST_PLUGIN_SYSTEM_PATH_1_0 = lib.makeSearchPathOutput "lib" "lib/gstreamer-1.0" [
		pkgs.gst_all_1.gst-plugins-good
		pkgs.gst_all_1.gst-plugins-bad
		pkgs.gst_all_1.gst-plugins-ugly
		pkgs.gst_all_1.gst-plugins-base
		pkgs.gst_all_1.gst-plugins-rs
	];

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
		glib # for gnome.calendar .desktop file
		gnome-online-accounts-gtk
		# screenshot stuff
		wf-recorder
		slurp
		hyprshot
		satty
		# grim
		# flameshot
		# screenshot end
		jq # JSON parser
		wl-clipboard
		killall
		udiskie # automaunt usb 
		pavucontrol # sound control gui
		pamixer # sound control CLI
		playerctl # media control CLI
		hyprpicker # color picker
		networkmanagerapplet # Network control GUI
		wttrbar # waybar weather applet
		brillo
		gnome.gnome-calculator
		gnome.gnome-weather
		gnome.gnome-calendar
  ];
}
