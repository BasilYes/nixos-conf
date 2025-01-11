{ config
, pkgs
, pkgs-unstable
, pkgs-stable
, pkgs-extra
, extraOptions
, ...
}:

{
  programs = {
    steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
      package = pkgs-unstable.steam;
    };
    gamescope.enable = true;
    gamemode.enable = true;
  };

  hardware.graphics.enable = true;

  environment.systemPackages = with pkgs-unstable; [
    # bottles
    protonup-qt
    mangohud
    wineWowPackages.stable
    winetricks
    (lutris.override {
      extraPkgs = pkgs-unstable: [
        wineWowPackages.stable
        winetricks
      ];
      extraLibraries = pkgs-unstable: [
        # List library dependencies here
      ];
    })
    (heroic.override {
      extraPkgs = pkgs-unstable: [
        wineWowPackages.stable
        winetricks
      ];
      extraLibraries = pkgs-unstable: [
        # List library dependencies here
      ];
    })
  ]
  ++ lib.optionals (extraOptions.optionals or false) [
    # itch
    # ppsspp
  ];
}
