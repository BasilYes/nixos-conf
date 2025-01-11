# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config
, pkgs
, pkgs-stable
, pkgs-unstable
, pkgs-extra
, lib
, extraOptions
, ...
}:

{
  imports = [
    ./hardware/${extraOptions.hardwareFile}
    # ./stylix.nix
  ]
  ++ lib.optionals (extraOptions.nvidia or false) [ ./nvidia.nix ]
  ++ lib.optionals (extraOptions.amd or false) [ ./amd.nix ]
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
  boot.loader.systemd-boot.enable = false;
  #boot.loader.efi.canTouchEfiVariables = true;
  boot.loader = {
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot"; # ← use the same mount point here.
    };
    grub = {
      enable = true;
      efiSupport = true;
      # efiInstallAsRemovable = true; # in case canTouchEfiVariables doesn't work for your system
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
  hardware.bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot

  services.xserver.wacom.enable = true;
  # hardware.opentabletdriver = {
  #   enable = true;
  #   daemon.enable = true;
  # };

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

  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  services.printing = {
    enable = true;
    drivers = [ pkgs.hplipWithPlugin ];
  };

  zramSwap.enable = true;

  security.rtkit.enable = true;
  services.pulseaudio.enable = false;
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
    #     "org.freedesktop.impl.portal.FileChooser" = [ "gnome" ];
    #   };
    # };
  };

  security.pam.services.${extraOptions.displayManager or "gdm"}.enableGnomeKeyring = true;
  # security.pam.services.${extraOptions.displayManager or "gdm"}.kwallet.enable = true;
  security.polkit.enable = true;

  nixpkgs.config.allowUnfree = true;

  programs.nix-ld.enable = true;
  # programs.nix-ld.libraries = with pkgs; [
  #   vulkan-loader
  #   # glib
  #   libGL
  #   xorg.libX11
  #   xorg.libXcursor
  #   xorg.libXinerama
  #   xorg.libXext
  #   xorg.libXrandr
  #   xorg.libXrender
  #   xorg.libXi
  #   xorg.libXfixes
  #   # stdenv.cc.cc.lib
  #   # fontconfig
  #   # freetype
  #   # dbus
  #   libxkbcommon
  #   alsa-lib
  # ];

  programs.kdeconnect = {
    enable = true;
    package = pkgs-unstable.valent;
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

  environment.systemPackages = with pkgs-unstable; [
    # (appimage-run.override {
    #   extraPkgs = pkgs: [
    #     libsecret
    #     xorg.libxkbfile
    #     ffmpeg
    #   ];
    # })
    appimage-run
    atuin
    audacity
    anytype
    antimicrox
    # barrier
    lan-mouse # Multiple pc mouse share
    baobab # Disk Usage Analyzer
    brave
    curtail
    discord-canary
    git
    graphicsmagick
    hunspell
    hunspellDicts.en_US
    hunspellDicts.ru_RU
    inkscape
    imagemagick
    # iamb
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
    # obs-studio
    obsidian
    (pkgs.wrapOBS {
      plugins = with pkgs.obs-studio-plugins; [
        obs-vkcapture
        obs-vaapi
        # obs-gstreamer
      ];
    })
    onlyoffice-bin_latest
    openssh
    pdfarranger
    (callPackage ./derivations/super-productivity.nix { }) # super-productivity
    # session-desktop
    # screenkey
    telegram-desktop
    thunderbird
    qjackctl
    qbittorrent
    qalculate-gtk # Calculator app
    vivaldi
    vlc
    # vesktop # Discord app
    unzip
    zip
  ]
  ++ lib.optionals (extraOptions.optionals or false) [
    gimp
    # davinci-resolve
    # deltachat-desktop
    # teamspeak5_client
    # mellowplayer # web player (useless when I have PWA)
    # cinnamon.warpinator # send file cross device
    # aseprite # need compilation
    # blockbench using EOL electron
    libreoffice
    lorien
    # reaper
    # zrythm
    # zettlr
  ]
  ++ lib.optionals (extraOptions.amd or false) [
    blender-hip
  ]
  ++ lib.optionals (!(extraOptions.amd or false)) [
    blender
  ];

  nixpkgs.overlays = [
    # (self: super: {
    #     super-productivity = pkgs.symlinkJoin {
    #     name = "super-productivity";
    #     paths = [ super.super-productivity ];
    #     buildInputs = [ pkgs.makeWrapper ];
    #     postBuild = ''
    #       wrapProgram $out/bin/super-productivity \
    #         --add-flags "--ozone-platform-hint=auto --disable-gpu-compositing"
    #     '';
    #   };
    # })
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
  ] ++ lib.optionals (!(extraOptions.forceWayland or false))
    [
      (self: super: {
        vesktop = pkgs.symlinkJoin {
          name = "vesktop";
          paths = [ super.vesktop ];
          buildInputs = [ pkgs.makeWrapper ];
          postBuild = ''
            wrapProgram $out/bin/vesktop \
              --add-flags "--disable-gpu-compositing"
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
              --add-flags "--disable-gpu-compositing"
          '';
          # --add-flags "--disable-gpu-compositing --proxy-server='http://127.0.0.1:8000'"
        };
      })
      # (self: super: {
      #   obs-studio = pkgs.symlinkJoin {
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

  fonts.packages = with pkgs-unstable; [
    corefonts
    vistafonts

    icomoon-feather
    # ]
    # ++ lib.optionals (extraOptions.optionals or false) [
    #   nerdfonts
    #   google-fonts
    # ]
    # ++ lib.optionals (!(extraOptions.optionals or false)) [
    nerd-fonts.fira-code
    nerd-fonts.iosevka
    nerd-fonts.jetbrains-mono

    (google-fonts.override {
      fonts = [
        "GrapeNuts"
      ];
    })
  ];

  networking.firewall = {
    checkReversePath = false;
    allowedTCPPorts = [ 42000 42001 7777 8060 ];
    allowedUDPPorts = [ 42000 42001 7777 8060 ];
  };

  system.stateVersion = extraOptions.nixVersion;
}
