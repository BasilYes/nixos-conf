{ config, pkgs, extraOptions, ... }:

{
  virtualisation.docker.enable = true;
  users.users.${extraOptions.userName}.extraGroups = [ "docker" ];
  environment.systemPackages = with pkgs; [
    binaryen
    cmake
    gdb
    gnumake
    scons
    gcc
    pkg-config
    wayland-scanner
    python3
    rustup
    # (python3.withPackages (ps: [
    #   ps.pyqt6
    # ]))
    # podman
    # emscripten
    lazygit
    zed-editor
    # shellcheck # shell spell check (zed)
    # shfmt # shell formatter (zed)
    # kdePackages.full
    #kdePackages.qtbase
    #qtcreator
    #kdePackages.qttools
    jdk
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
