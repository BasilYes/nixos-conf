{ config
, pkgs
, pkgs-unstable
, pkgs-stable
, pkgs-blender
, extraOptions
, ...
}:

{
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    package = pkgs-unstable.steam;
  };

  hardware.graphics.enable = true;

  environment.systemPackages = with pkgs; [
    pkgs-blender.bottles
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
      extraLibraries = pkgs: [
        # List library dependencies here
      ];
    })
    (pkgs-blender.heroic.override {
      extraPkgs = pkgs: [
        wineWowPackages.stable
        winetricks
      ];
      extraLibraries = pkgs: [
        # List library dependencies here
      ];
    })
  ]
  ++ lib.optionals (extraOptions.optionals or false) [
    # itch
    # ppsspp
  ];
}
