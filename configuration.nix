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
  imports =
    [
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
    ++ lib.optionals (extraOptions.network or false) [ ./network.nix ]
    ++ lib.optionals (extraOptions.gaming or false) [ ./gaming.nix ];

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  boot = {
    # Bootloader.
    loader = {
      systemd-boot.enable = false;
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
    supportedFilesystems = [ "ntfs" ];
    binfmt.registrations.appimage = {
      wrapInterpreterInShell = false;
      interpreter = "${pkgs.appimage-run}/bin/appimage-run";
      recognitionType = "magic";
      offset = 0;
      mask = ''\xff\xff\xff\xff\x00\x00\x00\x00\xff\xff\xff'';
      magicOrExtension = ''\x7fELF....AI\x02'';
    };
  };

  hardware = {
    graphics.enable = true;
    bluetooth.enable = true; # enables support for Bluetooth
    bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot
  };

  # hardware.opentabletdriver = {
  #   enable = true;
  #   daemon.enable = true;
  # };

  networking = {
    hostName = extraOptions.hostName;
    networkmanager.enable = true;
    firewall = {
      checkReversePath = false;
      allowedTCPPorts = [
        42000
        42001
        7777
        8060
        8188
        5900
      ];
      allowedUDPPorts = [
        42000
        42001
        7777
        8060
        8188
      ];
    };
  };

  # Set your time zone.
  time.timeZone = "Europe/Moscow";

  zramSwap.enable = true;
  security.rtkit.enable = true;

  security.pam.services.${extraOptions.displayManager or "gdm"}.enableGnomeKeyring = true;
  # security.pam.services.${extraOptions.displayManager or "gdm"}.kwallet.enable = true;
  security.polkit.enable = true;

  # Select internationalisation properties.
  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
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
  };

  services = {
    xserver = {
      enable = true;
      wacom.enable = true;
      xkb = {
        layout = "us";
        variant = "";
      };
      displayManager.${extraOptions.displayManager or "gdm"}.enable = true;
    };
    printing = {
      enable = true;
      drivers = [ pkgs.hplipWithPlugin ];
    };
    pulseaudio.enable = false;
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
    };
    libinput.enable = true;
    flatpak.enable = true;
    tailscale.enable = true;
    atuin.enable = true;
    gnome.gnome-keyring.enable = true;

    ollama = {
      enable = true;
      acceleration = "rocm";
      package = pkgs-unstable.ollama-rocm;
      environmentVariables = {
        HCC_AMDGPU_TARGET = "gfx1101"; # used to be necessary, but doesn't seem to anymore
      };
      rocmOverrideGfx = "11.0.1";
      # host = "0.0.0.0";
      # port = 11434;
      # openFirewall = true;
    };
    open-webui = {
      enable = true;
      # package = pkgs-extra.open-webui;
      host = "0.0.0.0";
      port = 8080;
      openFirewall = true;
    };
  };

  # users.users.guest = {
  #   description = "Guest";
  #   hashedPassword = "";
  #   isNormalUser = true;
  #   extraGroups = [ "wheel" ];
  # };
  users.users.${extraOptions.userName} = {
    isNormalUser = true;
    description = "${extraOptions.userName}";
    extraGroups = [
      "networkmanager"
      "wheel"
      "libvirtd"
      "video"
    ];
    packages = with pkgs; [
    ];
  };

  xdg.portal = {
    enable = true;
  };

  nixpkgs.config = {
    allowUnfree = true;
  };

  programs = {
    nix-ld.enable = true;
    amnezia-vpn.enable = true;
    kdeconnect = {
      enable = true;
      package = pkgs-unstable.valent;
    };
    bash.blesh.enable = true;
    dconf.enable = true;
    gnupg = {
      agent = {
        enable = true;
        pinentryPackage = pkgs.pinentry-gnome3;
      };
    };
    seahorse.enable = true;
  };

  environment.systemPackages =
    with pkgs-unstable;
    [
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
      comma
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
      kdePackages.kdenlive
      kdePackages.qtwayland
      linux-wifi-hotspot
      obsidian
      # obs-studio
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
      tree
      thunderbird
      qjackctl
      qbittorrent
      qalculate-gtk # Calculator app
      vivaldi
      vlc
      vesktop # Discord app
      unzip
      wireguard-tools
      waypipe
      wayvnc
      yt-dlp # Youtube downloader
      zip
    ]
    ++ lib.optionals (extraOptions.optionals or false) [
      gimp
      # davinci-resolve
      # aseprite # need compilation
      # blockbench using EOL electron
      libreoffice
      lorien
      # reaper
      # zrythm
    ]
    ++ lib.optionals (extraOptions.amd or false) [
      blender-hip
    ]
    ++ lib.optionals (!(extraOptions.amd or false)) [
      blender
    ];

  nixpkgs.overlays = [
    # (self: super: {
    #   telegram-desktop = pkgs.symlinkJoin {
    #     name = "telegram-desktop";
    #     paths = [ super.telegram-desktop ];
    #     buildInputs = [ pkgs.makeWrapper ];
    #     postBuild = ''
    #       wrapProgram $out/bin/telegram-desktop \
    #         --set QT_QPA_PLATFORMTHEME flatpak
    #     '';
    #   };
    # })
  ];

  fonts.packages = with pkgs-unstable; [
    corefonts
    vistafonts
    icomoon-feather
    nerd-fonts.fira-code
    nerd-fonts.iosevka
    nerd-fonts.jetbrains-mono
    (google-fonts.override {
      fonts = [
        "GrapeNuts"
      ];
    })
  ];

  system.stateVersion = extraOptions.nixVersion;
}
