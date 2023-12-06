{ config, pkgs, ... }:

{
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  users.users.basilyes = {
    packages = with pkgs; [
      gnomeExtensions.weather-or-not
      gnomeExtensions.vitals
      gnomeExtensions.appindicator
    ];
  };
  environment.systemPackages = with pkgs; [
    gnome.nautilus
    gnome3.gnome-tweaks
  ];
}
