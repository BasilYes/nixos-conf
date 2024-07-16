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
		wayland-scanner
    (python3.withPackages (ps: [
			ps.pyqt6
		]))
		kdePackages.qtwayland
		# podman
	  # emscripten
    lazygit
		zed-editor
    #kdePackages.full
    #kdePackages.qtbase
    #qtcreator
    jdk17
    vscode
  ]
	++ lib.optionals (extraOptions.optionals or false) [
    nodePackages.nodejs
		unityhub
		p4v
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
