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
      ./build.nix
    ];

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
  /*hardware.pulseaudio.enable = true;
  hardware.pulseaudio.extraConfig = [
    "unload-module tsched"
    "unload-module module-suspend-on-idle"
  ];*/
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };
  /*environment.etc = let
    json = pkgs.formats.json {};
  in {
    "pipewire/pipewire.conf.d/92-low-latency.conf".text = ''
      context.properties = {
        default.clock.rate = 48000
        default.clock.quantum = 8192
        default.clock.min-quantum = 8192
        default.clock.max-quantum = 8192
      }
    '';
  };*/
  
  services.xserver.libinput.enable = true;
  services.flatpak.enable = true;
  services.tailscale.enable = true;
  services.atuin.enable = true;

  users.users.basilyes = {
    isNormalUser = true;
    description = "basilyes";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      
    ];
  };

  nixpkgs.config.allowUnfree = true;
  programs.bash.blesh.enable = true;
  programs.dconf.enable = true;
  programs.gnupg = {
    agent = {
      enable = true;
      pinentryFlavor = "gnome3";
    };
  };
  environment.systemPackages = with pkgs; [
    (callPackage ./gitnuro/fhsenv.nix {
      gitnuro-unwrapped = (callPackage ./gitnuro/default.nix {});
    })
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
    chromium
    discord
    discord-canary
    discord-screenaudio
    easyeffects
    firefox
    gcolor3
    gimp
    git
    gittyup
    google-chrome
    haruna
    hunspell
    hunspellDicts.en_US
    hunspellDicts.ru_RU
    inkscape
    imagemagick
    jdk17
    keepassxc
    krita
    libreoffice
    libsForQt5.kdenlive
    lorien
    obs-studio
    onlyoffice-bin_latest
    openssh
    pdfarranger
    rhythmbox
    reaper
    qjackctl
    telegram-desktop
    trayscale
    vscode
    webcord
    unzip
    zrythm
  ];

  fonts.packages = with pkgs; [
    corefonts
    vistafonts
  ];
  
  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?

}
