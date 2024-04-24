{ config, pkgs, ... }:

{

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };

  hardware.opengl.driSupport32Bit = true;
  hardware.opengl.driSupport = true;

  environment.systemPackages = with pkgs; [
    ppsspp
    protonup-qt
    gamemode
    mangohud
    wineWowPackages.stable
    winetricks
    #itch
    (lutris.override {
      extraPkgs = pkgs: [
        wineWowPackages.stable
        winetricks
      ];
      extraLibraries =  pkgs: [
        # List library dependencies here
      ];
    })
    (heroic.override {
      extraPkgs = pkgs: [
        wineWowPackages.stable
        winetricks
      ];
      extraLibraries =  pkgs: [
        # List library dependencies here
      ];
    })
  ];
}
