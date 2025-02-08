{ config
, lib
, pkgs
, extraOptions
, inputs
, ...
}:
{
  xdg.configFile."hypr/hypridle.conf".source = ../config/hypr/hypridle.conf;
  xdg.configFile."hypr/hyprlock.conf".source = ../config/hypr/hyprlock.conf;
  xdg.configFile."hypr/layout.xkb".source = ../config/hypr/layout.xkb;
  xdg.configFile."hypr/scripts".source = ../config/hypr/scripts;

  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
    extraConfig = (builtins.readFile ../config/hypr/hyprland.conf);
    plugins = [
    ];
    # package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    # portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
    package = null;
    portalPackage = null;
  };
}
