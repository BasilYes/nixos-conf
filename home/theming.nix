{ pkgs, lib, ... }:


{
  qt = {
    enable = true;
    # platformTheme.name = "gtk";
    # style = {
    #   name = "gtk2";
    #   package = pkgs.libsForQt5.breeze-qt5;
    #   # package = pkgs.kdePackages.breeze;
    # };

    platformTheme.name = "qtct";
    # style.name = "kvantum";

    # # platformTheme.name = "gtk";
    # style = {
    #   name = "adwaita-dark";
    # };
  };

  xdg.configFile = {
    qt5ct = {
      target = "qt5ct/qt5ct.conf";
      text = lib.generators.toINI { } {
        Appearance = {
          icon_theme = "breeze-dark";
          style = "Adwaita-Dark";
          # icon_theme = "HighContrast";
          # style = "Breeze";
        };
      };
    };
    qt6ct = {
      target = "qt6ct/qt6ct.conf";
      text = lib.generators.toINI { } {
        Appearance = {
          icon_theme = "breeze-dark";
          style = "Adwaita-Dark";
          # icon_theme = "HighContrast";
          # style = "Breeze";
        };
      };
    };
  };

  gtk = {
    enable = true;
    # gtk3.extraCss = "@import url(\"file://${pkgs.adw-gtk3}/share/themes/adw-gtk3-dark/gtk-3.0/gtk.css\");";
    cursorTheme = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Classic";
    };
    theme = {
      # package = pkgs.adw-gtk3;
      # name = "adw-gtk3-dark";
      package = pkgs.gnome-themes-extra;
      name = "Adwaita-dark";
    };
    iconTheme = {
      package = pkgs.adwaita-icon-theme;
      name = "Adwaita";
    };
    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = true;
    };
    # gtk2.extraConfig = ''
    #   gtk-application-prefer-dark-theme = 1
    # '';
  };

  dconf = {
    enable = true;
    settings."org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };
  };

  home.sessionVariables = {
    QT_QPA_PLATFORMTHEME = "qt5ct";
    # GTK_THEME = "Adwaita:dark";
  };

  home.packages = with pkgs; [
    gnome-themes-extra
    # kdePackages.breeze
    kdePackages.breeze-icons
    # libsForQt5.breeze-qt5
    # libsForQt5.breeze-icons
    adwaita-qt
    adwaita-qt6
    #   adwaita-icon-theme
    #    adw-gtk3
    #   cinnamon.mint-cursor-themes
  ];
}
