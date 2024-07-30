{ config, pkgs, extraOptions, ... }:

{
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };

  hardware.graphics.enable = true;

  environment.systemPackages = with pkgs; [
    protonup-qt
    gamemode
		gamescope
    mangohud
    wineWowPackages.stable
    winetricks
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
	]
	++ lib.optionals (extraOptions.optionals or false) [
    # itch
    # ppsspp
	];
}
