{ config, pkgs, ... }:

{
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  users.users.basilyes = {
    packages = with pkgs; [
      gnomeExtensions.weather-or-not
      gnomeExtensions.vitals
      gnomeExtensions.appindicator
      gnomeExtensions.tiling-assistant
      gnomeExtensions.mpris-label
      gnomeExtensions.quick-lang-switch
    ];
  };
  environment.systemPackages = with pkgs; [
    gnome.nautilus
    gnome3.gnome-tweaks
  ];
}
