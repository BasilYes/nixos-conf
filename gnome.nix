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
    nautilus
    # gnome-themes-extra
    gnome-tweaks
  ];
  
  networking.firewall = {
    allowedTCPPortRanges = [ { from = 1714; to = 1764; } ];
    allowedUDPPortRanges = [ { from = 1714; to = 1764; } ];
  };
}
