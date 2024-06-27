{ pkgs, ... }:


{
	qt = {
		enable = true;
		platformTheme.name = "gtk"; 
		style = {
			name = "adwaita-dark";
		};
	};

	gtk = {
		enable = true;
		cursorTheme = {
			package = pkgs.bibata-cursors;
			name = "Bibata-Modern-Classic";
		};
		theme = {
			package = pkgs.adw-gtk3;
			name = "adw-gtk3-dark";
		};
		iconTheme = {
			package = pkgs.gnome.adwaita-icon-theme;
			name = "Adwaita";
		};
		gtk3.extraConfig = {
			gtk-application-prefer-dark-theme = true;
		};
		gtk2.extraConfig = ''
			gtk-application-prefer-dark-theme = 1
		'';
	};

  dconf = {
    enable = true;
    settings."org/gnome/desktop/interface" = {
			color-scheme = "prefer-dark";
		};
  }; 

  # home.sessionVariables = {
  #   GTK_THEME = "Adwaita:dark";
  # };
	
	home.packages = with pkgs; [
		gnome.gnome-themes-extra
	# 	gnome.adwaita-icon-theme
	# 	adw-gtk3
	# 	adwaita-qt
	# 	cinnamon.mint-cursor-themes
	];
}