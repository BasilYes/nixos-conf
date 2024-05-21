{ config, pkgs, ... }

let
  stylix = pkgs.fetchFromGitHub {
    owner = "danth";
    repo = "stylix";
    rev = "...";
    sha256 = "...";
  };
in {
  imports = [ (import stylix).homeManagerModules.stylix ];
  stylix.image = ./wallpaper.jpg;
}
