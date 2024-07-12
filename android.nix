{ config, pkgs, extraOptions, ... }:

{
  programs.adb.enable = true;
  users.users.${extraOptions.userName}.extraGroups = ["adbusers"];
  environment.systemPackages = with pkgs; [
    android-studio
    scrcpy
  ];
}
