{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    binaryen
    cmake
    gdb
    scons
    gcc
    pkg-config
    python3
	  emscripten
    lazygit
    #kdePackages.full
    #kdePackages.qtbase
    #qtcreator
    jdk17
    vscode
    unityhub
  ];

  programs.npm.enable = true;

  nixpkgs.overlays = [
    (self: super: {
        vscode = pkgs.symlinkJoin {
        name = "vscode";
        paths = [ super.vscode ];
        buildInputs = [ pkgs.makeWrapper ];
        postBuild = ''
          wrapProgram $out/bin/code \
            --add-flags "--ozone-platform-hint=auto"
        '';
      };
    })
  ];
}
