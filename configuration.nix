# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./gnome.nix
      #./kde.nix
      ./gaming.nix
      ./basilyes.nix
      ./vm.nix
      ./nvidia.nix
      ./android.nix
      ./develop.nix
	    #./stylix.nix
    ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

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

  hardware.opengl.driSupport32Bit = true;
  hardware.opengl.driSupport = true;

  networking.hostName = "basilyes-desktop";

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

  sound.enable = true;
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

  users.users.basilyes = {
    isNormalUser = true;
    description = "basilyes";
    extraGroups = [ "networkmanager" "wheel" "libvirtd" ];
    packages = with pkgs; [
      
    ];
  };

  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    #gnome.zenity
    vulkan-loader
    libGL
    xorg.libX11
    xorg.libXcursor
    xorg.libXinerama
    xorg.libXext
    xorg.libXrandr
    xorg.libXrender
    xorg.libXi
    xorg.libXfixes
    libxkbcommon
    alsa-lib
  ];

  nixpkgs.config.allowUnfree = true;

  qt = {
    enable = true;
    platformTheme = "kde";
    style = "breeze";
  };
  programs.bash.blesh.enable = true;
  programs.dconf.enable = true;
  programs.gnupg = {
    agent = {
      enable = true;
      pinentryPackage = pkgs.pinentry-gnome3;
    };
  };
  environment.systemPackages = with pkgs; [
    gitnuro
    (appimage-run.override {
      extraPkgs = pkgs: [
        libsecret
        xorg.libxkbfile
        ffmpeg
      ];
    })
    atuin
    anytype
    audacity
    aseprite
    blender
    blockbench
    brave
    vivaldi
    cinnamon.warpinator
    chromium
    curtail
    discord
    discord-canary
    discord-screenaudio
    easyeffects
    element-desktop
    firefox
    gcolor3
    gimp
    git
    gittyup
    google-chrome
    graphicsmagick
    haruna
    hunspell
    hunspellDicts.en_US
    hunspellDicts.ru_RU
    inkscape
    imagemagick
    keepassxc
    krita
    #kdePackages.kolourpaint
    #kdePackages.breeze-icons
    #kdePackages.kdenlive
    libsForQt5.breeze-icons
    libsForQt5.kdenlive
    libsForQt5.kolourpaint
    libreoffice
    lorien
    mellowplayer
    nextcloud-client
    obsidian
    obs-studio
    onlyoffice-bin_latest
    openssh
    pdfarranger
    pdfmixtool
    rhythmbox
    reaper
    screenkey
    qjackctl
    qbittorrent
    telegram-desktop
    trayscale
    thunderbird
    vim
    webcord
    unzip
    xwaylandvideobridge
    zrythm
    zettlr
  ];

  fonts.packages = with pkgs; [
    corefonts
    vistafonts
  ];
  
  networking.firewall = {
    allowedTCPPorts = [ 42000 42001 ];
    allowedUDPPorts = [ 42000 42001 ];
  };
 
  system.stateVersion = "23.11";
}
