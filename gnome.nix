{ config, pkgs, extraOptions, ... }:

{
  services.xserver.desktopManager.gnome.enable = true;
  users.users.${extraOptions.userName} = {
    packages = with pkgs; [
      gnomeExtensions.weather-or-not
      gnomeExtensions.vitals
      gnomeExtensions.appindicator
      gnomeExtensions.tiling-assistant
      gnomeExtensions.mpris-label
      gnomeExtensions.quick-lang-switch
      gnomeExtensions.fullscreen-avoider
      gnomeExtensions.gsconnect
      # gnomeExtensions.another-window-session-manager
    ];
  };
  environment.gnome.excludePackages = (with pkgs; [
    gnome-photos
    gnome-tour
    cheese # webcam tool
    epiphany # web browser
    geary # email reader
    totem # video player
  ]) ++ (with pkgs.gnome; [
    gnome-music
    gnome-characters
  ]);
  environment.systemPackages = with pkgs; [
    gnome-extension-manager
    nautilus
    # gnome-themes-extra
    gnome-tweaks
  ];

  networking.firewall = {
    allowedTCPPortRanges = [{ from = 1714; to = 1764; }];
    allowedUDPPortRanges = [{ from = 1714; to = 1764; }];
  };
}
