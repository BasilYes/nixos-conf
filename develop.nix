{ config, pkgs, extraOptions, ... }:

{
  environment.systemPackages = with pkgs; [
    binaryen
    cmake
		docker
    gdb
    gnumake
    scons
    gcc
    pkg-config
    python3
		p4v
		# podman
	  # emscripten
    lazygit
    nodePackages.nodejs
    #kdePackages.full
    #kdePackages.qtbase
    #qtcreator
    jdk17
    vscode
  ]
	++ lib.optionals (extraOptions.optionals or false) [
		unityhub
	];

  programs.npm.enable = true;

  # nixpkgs.overlays = [
  #   (self: super: {
  #       vscode = pkgs.symlinkJoin {
  #       name = "vscode";
  #       paths = [ super.vscode ];
  #       buildInputs = [ pkgs.makeWrapper ];
  #       postBuild = ''
  #         wrapProgram $out/bin/code \
  #           --add-flags "--ozone-platform-hint=auto"
  #       '';
  #     };
  #   })
  # ];
}
