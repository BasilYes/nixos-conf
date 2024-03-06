{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    binaryen
    scons
    gcc
    pkg-config
    emscripten
  ];
}
