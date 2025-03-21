{
  inputs,
  pkgs,
  pkgs-stable,
  pkgs-unstable,
  lib,
  extraOptions,
  ...
}:

{
  nix.settings = {
    substituters = [ "https://hyprland.cachix.org" ];
    trusted-public-keys = [ "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=" ];
  };
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
    withUWSM = true;
    package = pkgs-unstable.hyprland;
    portalPackage = pkgs-unstable.xdg-desktop-portal-hyprland;
    # package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    # portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
  };
  services.hypridle = {
    enable = true;
    package = pkgs-unstable.hypridle;
  };
  programs.hyprlock = {
    enable = true;
    package = pkgs-unstable.hyprlock;
  };

  environment.sessionVariables = {
    # Hint electron apps to use wayland
    # NIXOS_OZONE_WL = "1";
    ${if (extraOptions.forceWayland or false) then "NIXOS_OZONE_WL" else null} = "1";
  };

  xdg.portal.extraPortals = lib.mkForce (
    [
      pkgs.xdg-desktop-portal-gtk # For both
      pkgs.xdg-desktop-portal-hyprland # For Hyprland
      #   pkgs.xdg-desktop-portal-gnome # For gnome and gnome file picker
      # ] );
    ]
    ++ lib.optionals (!(extraOptions.gnome or false)) [ pkgs.xdg-desktop-portal-gnome ]
  ); # For GNOME

  environment.etc = {
    "scripts/suspend".source = ../scripts/suspend.sh;
  };
  security.sudo.extraRules = [
    {
      users = [ extraOptions.userName ];
      commands = [
        {
          command = "/etc/scripts/suspend";
          options = [ "NOPASSWD" ];
        }
      ];
    }
  ];
  # environment.${if (extraOptions.nvidia or false) then "variables" else null} = {
  #   LIBVA_DRIVER_NAME = "nvidia";
  #   XDG_SESSION_TYPE = "wayland";
  #   GBM_BACKEND = "nvidia-drm";
  #   __GLX_VENDOR_LIBRARY_NAME = "nvidia";
  #   NVD_BACKEND = "direct";
  # };

  # xdg.portal.extraPortals  = [
  #   pkgs.xdg-desktop-portal-hyprland
  #   pkgs.xdg-desktop-portal-gnome
  # ]
  # ++ lib.optionals (!(extraOptions.gnome or false)) [ pkgs.xdg-desktop-portal-gtk ];

  services.udisks2.enable = true;
  services.blueman.enable = true;
  services.gvfs.enable = true;
  services.gnome.gnome-online-accounts.enable = true;
  services.displayManager.defaultSession = "hyprland-uwsm";
  services.gnome.evolution-data-server.enable = true;

  environment.sessionVariables.GST_PLUGIN_SYSTEM_PATH_1_0 =
    lib.makeSearchPathOutput "lib" "lib/gstreamer-1.0"
      [
        pkgs.gst_all_1.gst-plugins-good
        pkgs.gst_all_1.gst-plugins-bad
        pkgs.gst_all_1.gst-plugins-ugly
        pkgs.gst_all_1.gst-plugins-base
        pkgs.gst_all_1.gst-plugins-rs
      ];

  environment.systemPackages = with pkgs-unstable; [
    (waybar.overrideAttrs (oldAttrs: {
      mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
    }))
    swaynotificationcenter
    libnotify
    loupe # image viewer
    kitty # termonal
    rofi-wayland # app select panel
    # screenshot and screencast stuff
    hyprcursor
    hyprpolkitagent
    ffmpeg
    pkgs-stable.wf-recorder
    slurp
    hyprshot
    satty
    socat # Read socket for hyprland scripts
    gnome-text-editor # text editor
    lm_sensors # for sensor (max temp waybar widget)
    cmatrix
    # grim
    # flameshot
    # screenshot end
    jq # JSON parser
    wl-clipboard # copy-paste
    killall # kill all by name
    # mission-center # system monitor
    gnome-system-monitor # system monitor
    gnome-disk-utility # disk util
    # resources # system monitor
    udiskie # automaunt usb
    pavucontrol # sound control gui
    pamixer # sound control CLI
    playerctl # media control CLI
    hyprpicker # color picker
    networkmanagerapplet # Network control GUI
    wttrbar # waybar weather applet
    brightnessctl # brightness control
    glib # for gnome.calendar .desktop file
    crow-translate
    gnome-weather
    gnome-calendar
    gnome-clocks
    nautilus
    gnome-online-accounts-gtk
  ];
}
