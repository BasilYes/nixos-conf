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

  xdg.portal.extraPortals = lib.mkForce ( [
    pkgs.xdg-desktop-portal-gtk # For both
    pkgs.xdg-desktop-portal-hyprland # For Hyprland
		pkgs.xdg-desktop-portal-gnome # For gnome and gnome file picker
  ] );
	# ++ lib.optionals (!(extraOptions.gnome or false)) [ pkgs.xdg-desktop-portal-gnome ] ); # For GNOME 

	# xdg.portal.extraPortals	= [
  #   pkgs.xdg-desktop-portal-hyprland
  #   pkgs.xdg-desktop-portal-gnome
  # ]
	# ++ lib.optionals (!(extraOptions.gnome or false)) [ pkgs.xdg-desktop-portal-gtk ];

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
		(waybar.overrideAttrs (oldAttrs: {
				mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
			})
		)
		swaynotificationcenter
		libnotify
		loupe # image viewer
		kitty # termonal
		rofi-wayland # app select panel
		# screenshot and screencast stuff
		ffmpeg
		wf-recorder
		slurp
		hyprshot
		satty
		gnome-text-editor # text editor
		lm_sensors # for sensor (max temp waybar widget)
		# grim
		# flameshot
		# screenshot end
		jq # JSON parser
		wl-clipboard # copy-paste
		killall # kill all by name
		mission-center # system monitor
		# resources # system monitor
		udiskie # automaunt usb 
		pavucontrol # sound control gui
		pamixer # sound control CLI
		playerctl # media control CLI
		hyprpicker # color picker
		networkmanagerapplet # Network control GUI
		wttrbar # waybar weather applet
		brillo # brightness control
		glib # for gnome.calendar .desktop file
		gnome.gnome-calculator
		gnome.gnome-weather
		gnome.gnome-calendar
		gnome.nautilus
		gnome-online-accounts-gtk
  ];
}
