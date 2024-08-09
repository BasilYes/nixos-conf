# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, extraOptions, ... }:

{
  imports = [
    ./hardware/${extraOptions.hardwareFile}
		# ./stylix.nix
	]
	++ lib.optionals (extraOptions.nvidia or false) [ ./nvidia.nix ]
	++ lib.optionals (extraOptions.android or false) [ ./android.nix ]
	++ lib.optionals (extraOptions.develop or false) [ ./develop.nix ]
	++ lib.optionals (extraOptions.vm or false) [ ./vm.nix ]
	++ lib.optionals (extraOptions.hyprland or false) [ ./hyprland.nix ]
	++ lib.optionals (extraOptions.gnome or false) [ ./gnome.nix ]
	++ lib.optionals (extraOptions.kde or false) [ ./kde.nix ]
	++ lib.optionals (extraOptions.gaming or false) [ ./gaming.nix ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];


  services.xserver.displayManager.${extraOptions.displayManager or "gdm"}.enable = true;

  # Bootloader.
  #boot.loader.systemd-boot.enable = true;
  #boot.loader.efi.canTouchEfiVariables = true;
  boot.loader = {
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot/efi"; # ← use the same mount point here.
    };
    grub = {
       efiSupport = true;
       #efiInstallAsRemovable = true; # in case canTouchEfiVariables doesn't work for your system
       device = "nodev";
       useOSProber = true;
    };
  };

  boot.supportedFilesystems = [ "ntfs" ];

  boot.binfmt.registrations.appimage = {
    wrapInterpreterInShell = false;
    interpreter = "${pkgs.appimage-run}/bin/appimage-run";
    recognitionType = "magic";
    offset = 0;
    mask = ''\xff\xff\xff\xff\x00\x00\x00\x00\xff\xff\xff'';
    magicOrExtension = ''\x7fELF....AI\x02'';
  };

  hardware.graphics.enable = true;
  hardware.bluetooth.enable = true; # enables support for Bluetooth
  # hardware.opentabletdriver = {
  #   enable = true;
  #   daemon.enable = true;
  # };
  # hardware.bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot

  networking.hostName = extraOptions.hostName;

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Moscow";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "ru_RU.UTF-8";
    LC_IDENTIFICATION = "ru_RU.UTF-8";
    LC_MEASUREMENT = "ru_RU.UTF-8";
    LC_MONETARY = "ru_RU.UTF-8";
    LC_NAME = "ru_RU.UTF-8";
    LC_NUMERIC = "ru_RU.UTF-8";
    LC_PAPER = "ru_RU.UTF-8";
    LC_TELEPHONE = "ru_RU.UTF-8";
    LC_TIME = "en_GB.UTF-8";
  };

  services.xserver.enable = true;

  services.xserver.wacom.enable = true;

  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  services.printing = {
    enable = true;
    drivers = [ pkgs.hplipWithPlugin ];
  };

  zramSwap.enable = true;

  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  services.libinput.enable = true;
  services.flatpak.enable = true;
  services.tailscale.enable = true;
  services.atuin.enable = true;
  services.gnome.gnome-keyring.enable = true;

  # users.users.guest = {
  #   description = "Guest";
  #   hashedPassword = "";
  #   isNormalUser = true;
  #   extraGroups = [ "wheel" ];
  # };

  users.users.${extraOptions.userName} = {
    isNormalUser = true;
    description = "${extraOptions.userName}";
    extraGroups = [ "networkmanager" "wheel" "libvirtd" "video" ];
    packages = with pkgs; [

    ];
  };

	xdg.portal = {
    enable = true;
		# config = {
    #   common = {
    #     default = [
    #       "gtk"
    #     ];
    #   };
    #   hyprland = {
    #     default = [
    #       "hyprland"
    #       "gtk"
    #     ];
		# 		"org.freedesktop.impl.portal.FileChooser" = [ "gnome" ];
    #   };
    # };
  };

  security.pam.services.gdm-password.enableGnomeKeyring = true;
  security.polkit.enable = true;

  nixpkgs.config.allowUnfree = true;

  programs.nix-ld.enable = true;
  # programs.nix-ld.libraries = with pkgs; [
  #   vulkan-loader
	# 	# glib
  #   libGL
  #   xorg.libX11
  #   xorg.libXcursor
  #   xorg.libXinerama
  #   xorg.libXext
  #   xorg.libXrandr
  #   xorg.libXrender
  #   xorg.libXi
  #   xorg.libXfixes
	# 	# stdenv.cc.cc.lib
	# 	# fontconfig
	# 	# freetype
	# 	# dbus
  #   libxkbcommon
  #   alsa-lib
  # ];

	programs.kdeconnect = {
		enable = true;
		package = pkgs.valent;
	};

  programs.bash.blesh.enable = true;
  programs.dconf.enable = true;
  programs.gnupg = {
    agent = {
      enable = true;
      pinentryPackage = pkgs.pinentry-gnome3;
    };
  };
  programs.seahorse.enable = true;

  environment.systemPackages = with pkgs; [
    # (appimage-run.override {
    #   extraPkgs = pkgs: [
    #     libsecret
    #     xorg.libxkbfile
    #     ffmpeg
    #   ];
    # })
    atuin
    audacity
    anytype
    blender
    curtail
    git
    graphicsmagick
    hunspell
    hunspellDicts.en_US
    hunspellDicts.ru_RU
    inkscape
    imagemagick
    iamb
    keepassxc
    krita
    pinta
    # kdePackages.kolourpaint
    # kdePackages.breeze-icons
    kdePackages.kdenlive
    kdePackages.qtwayland
    # libsForQt5.kdenlive
    # libsForQt5.breeze-icons
    # libsForQt5.kolourpaint
		linux-wifi-hotspot
    obs-studio
    onlyoffice-bin_latest
    openssh
    pdfarranger
    # screenkey
    telegram-desktop
		thunderbird
    qjackctl
    qbittorrent
    trayscale
    vivaldi
    vlc
    unzip
    zip
  ]
	++ lib.optionals (extraOptions.optionals or false) [
    obsidian
    gimp
		davinci-resolve
    # mellowplayer # web player (useless when I have PWA)
    # cinnamon.warpinator # send file cross device
    # aseprite # need compilation
    # blockbench using EOL electron
    libreoffice
    lorien
    reaper
    # zrythm
    # zettlr
	];

  nixpkgs.overlays = [
    (self: super: {
			telegram-desktop = pkgs.symlinkJoin {
        name = "telegram-desktop";
        paths = [ super.telegram-desktop ];
        buildInputs = [ pkgs.makeWrapper ];
        postBuild = ''
          wrapProgram $out/bin/telegram-desktop \
            --set QT_QPA_PLATFORMTHEME flatpak
        '';
      };
    })
    (self: super: {
        vivaldi = pkgs.symlinkJoin {
        name = "vivaldi";
        paths = [ super.vivaldi ];
        buildInputs = [ pkgs.makeWrapper ];
        postBuild = ''
          wrapProgram $out/bin/vivaldi \
            --add-flags "--disable-gpu-compositing --proxy-server='http://127.0.0.1:8085'"
        '';
      };
    })
    # --add-flags "--proxy-server='http://127.0.0.1:8000'"
    # (self: super: {
	  # 	obs-studio = pkgs.symlinkJoin {
    #     name = "obs-studio";
    #     paths = [ super.obs-studio ];
    #     buildInputs = [ pkgs.makeWrapper ];
    #     postBuild = ''
    #       wrapProgram $out/bin/obs \
    #         --set QT_QPA_PLATFORM xcb
    #     '';
    #   };
    # })
  ];

  fonts.packages = with pkgs; [
    corefonts
    vistafonts

    icomoon-feather
  # ]
	# ++ lib.optionals (extraOptions.optionals or false) [
  #   nerdfonts
  #   google-fonts
	# ]
	# ++ lib.optionals (!(extraOptions.optionals or false)) [
		(nerdfonts.override { fonts = [
        "FiraCode"
        "Iosevka"
        "JetBrainsMono"
      ];
    })
		(google-fonts.override { fonts = [
        "GrapeNuts"
      ];
    })
	];

  networking.firewall = {
    allowedTCPPorts = [ 42000 42001 ];
    allowedUDPPorts = [ 42000 42001 ];
  };

  system.stateVersion = extraOptions.nixVersion;
}
