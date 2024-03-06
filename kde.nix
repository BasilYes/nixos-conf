{ config, pkgs, ... }:

{
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.desktopManager.plasma6.enable = true;
  environment.systemPackages = with pkgs; [
    discover
    kdePackages.kaccounts-integration
    kdePackages.kaccounts-providers
    kdePackages.kio-gdrive
  ];

}
