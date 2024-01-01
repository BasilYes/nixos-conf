# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

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
    LC_TIME = "ru_RU.UTF-8";
  };

  services.xserver.enable = true;
  
  services.xserver = {
    layout = "us";
    xkbVariant = "";
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

  users.users.basilyes = {
    isNormalUser = true;
    description = "basilyes";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      
    ];
  };

  nixpkgs.config.allowUnfree = true;
  programs.dconf.enable = true;
  programs.gnupg = {
    agent = {
      enable = true;
      pinentryFlavor = "gnome3";
    };
  };
  environment.systemPackages = with pkgs; [
    (appimage-run.override {
      extraPkgs = pkgs: [
        libsecret
        xorg.libxkbfile
        ffmpeg
      ];
    })
    audacity
    blender
    chromium
    easyeffects
    firefox
    gimp
    git
    gittyup
    google-chrome
    haruna
    hunspell
    hunspellDicts.en_US
    hunspellDicts.ru_RU
    jdk17
    keepassxc
    krita
    libreoffice
    lorien
    nomachine-client
    obs-studio
    onlyoffice-bin_latest
    openssh
    pdfarranger
    qjackctl
    scons
    telegram-desktop
    trayscale
    vscode
    webcord
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
