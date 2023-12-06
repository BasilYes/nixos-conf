{ config, pkgs, ... }:

{
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.desktopManager.plasma5.enable = true;
  environment.systemPackages = with pkgs; [
    discover
    libsForQt5.kaccounts-integration
    libsForQt5.kaccounts-providers
    libsForQt5.kio-gdrive
  ];

}
