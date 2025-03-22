{ config
, pkgs
, pkgs-unstable
, pkgs-stable
, pkgs-extra
  # , rust-overlay
, extraOptions
, ...
}:

{
  virtualisation.docker.enable = true;
  users.users.${extraOptions.userName}.extraGroups = [ "docker" "dialout" ];
  #
  # nixpkgs.overlays = [
  #   rust-overlay.overlays.default
  # ];

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
    enableBashIntegration = true;
  };

  programs.npm.enable = true;

  nix.settings = {
    substituters = [ "https://devenv.cachix.org" ];
    trusted-public-keys = [ "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw=" ];
  };
  environment.systemPackages = with pkgs-unstable; [
    devenv
    arduino-ide
    # binaryen
    cmake
    gdb
    gnumake
    scons
    gcc
    pkg-config
    wayland-scanner
    python3
    nixd
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
    vscode
    rustup
    nil
    nixfmt-rfc-style
    # pkgs.rust-bin.stable.latest.default
    # (pkgs.rust-bin.stable.latest.default.override {
    #   extensions = [ "rust-analyzer" ];
    # })
  ]
  ++ lib.optionals (extraOptions.optionals or false) [
    nodePackages.nodejs
    unityhub
    # p4v
  ];

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
