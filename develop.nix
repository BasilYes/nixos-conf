{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    binaryen
    cmake
    gdb
    scons
    gcc
    pkg-config
	  emscripten
    #kdePackages.full
    #kdePackages.qtbase
    #qtcreator
    jdk17
    vscode
    unityhub
  ];
}
