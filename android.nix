{ config, pkgs, ... }:

{
  programs.adb.enable = true;
  users.users.basilyes.extraGroups = ["adbusers"];
  environment.systemPackages = with pkgs; [
    android-studio
    scrcpy
  ];
}
