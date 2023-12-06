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
    protonup-qt
    lutris
  ];

}