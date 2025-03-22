{ config
, pkgs
, pkgs-unstable
, extraOptions
, ...
}:

{
  programs.adb.enable = true;
  users.users.${extraOptions.userName}.extraGroups = [ "adbusers" ];
  environment.systemPackages = with pkgs-unstable; [
    android-studio
    scrcpy
  ];
}
