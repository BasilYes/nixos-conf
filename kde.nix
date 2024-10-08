{ config, pkgs, ... }:

{
  services.desktopManager.plasma6.enable = true;
  environment.systemPackages = with pkgs; [
    discover
    kdePackages.kaccounts-integration
    kdePackages.kaccounts-providers
    kdePackages.kio-gdrive
    kdePackages.wacomtablet
  ];
}
