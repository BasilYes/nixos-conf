{ pkgs, ... }:

{
  stylix = {
    image = pkgs.fetchurl {
      url = "https://4kwallpapers.com/images/wallpapers/galaxy-cosmic-3840x2160-14974.jpg";
      sha256 = "sha256-/AQnscqbS8+X65MVvd9Y9VWl3VOsJJerYlhS2n113UQ=";
    };

    base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-macchiato.yaml";

    polarity = "dark";

    fonts = {
      serif = {
        name = "Cantarell";
        package = pkgs.cantarell-fonts;
      };

      sansSerif = {
        name = "Cantarell";
        package = pkgs.cantarell-fonts;
      };

      monospace = {
        name = "Fira Code";
        package = pkgs.fira-code;
      };

      sizes = {
        applications = 11;
        desktop = 11;
      };
    };
  };
}

