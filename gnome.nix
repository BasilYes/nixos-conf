{ config, pkgs, ... }:

{
  services.xserver.desktopManager.gnome.enable = true;
  users.users.basilyes = {
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
  ]) ++ (with pkgs.gnome; [
    cheese # webcam tool
    gnome-music
    epiphany # web browser
    geary # email reader
    gnome-characters
    totem # video player
  ]);
  environment.systemPackages = with pkgs; [
    gnome-extension-manager
    gnome.nautilus
    # gnome.gnome-themes-extra
    gnome3.gnome-tweaks
  ];
  
  networking.firewall = {
    allowedTCPPortRanges = [ { from = 1714; to = 1764; } ];
    allowedUDPPortRanges = [ { from = 1714; to = 1764; } ];
  };
}
