{ config, pkgs, ... }:

{
  # stylix.image = pkgs.fetchurl {
  #   url = "https://www.pixelstalk.net/wp-content/uploads/2016/05/Epic-Anime-Awesome-Wallpapers.jpg";
  #   sha256 = "enQo3wqhgf0FEPHj2coOCvo7DuZv+x5rL/WIo4qPI50=";
  # };
  # stylix.base16Scheme = {
  #   base00 = "282828";
  #   base01 = "3c3836";
  #   base02 = "504945";
  #   base03 = "665c54";
  #   base04 = "bdae93";
  #   base05 = "d5c4a1";
  #   base06 = "ebdbb2";
  #   base07 = "fbf1c7";
  #   base08 = "fb4934";
  #   base09 = "fe8019";
  #   base0A = "fabd2f";
  #   base0B = "b8bb26";
  #   base0C = "8ec07c";
  #   base0D = "83a598";
  #   base0E = "d3869b";
  #   base0F = "d65d0e";
  # };
  # stylix.polarity = "dark";

  environment.systemPackages = with pkgs; [
    libnotify
  ];
  
  systemd.timers."good-night" = {
    wantedBy = [ "timers.target" ];
      timerConfig = {
        OnCalendar = "*-*-* 21:30:00";
        Unit = "good-night.service";
      };
  };

  systemd.services."good-night" = {
    script = ''
      action=""; \
      while [ "$action" != "shut" ]; do \
      ${pkgs.sudo}/bin/sudo -u basilyes XDG_RUNTIME_DIR=/run/user/$(id -u basilyes) ${pkgs.alsa-utils}/bin/aplay '/home/basilyes/Documents/notify.wav' & \
      action=$(${pkgs.sudo}/bin/sudo -u basilyes DISPLAY=:0 DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/$(id -u basilyes)/bus XDG_RUNTIME_DIR=/run/user/$(id -u basilyes) ${pkgs.libnotify}/bin/notify-send -u critical -A "shut=Shut down" -A "wait=Wait for a minute" By "Good night"); \
      case $action in \
      ("shut") break;; \
      (*) sleep 60;;\
      esac;\
      done;\
      systemctl poweroff
    '';
    serviceConfig = {
      Type = "oneshot";
      User = "root";
    };
  };
  
  
  systemd.timers."startup" = {
    wantedBy = [ "timers.target" ];
    timerConfig = {
      OnBootSec = "5min";
      Unit = "startup.service";
    };
  };

  systemd.services."startup" = {
    script = ''
    ${pkgs.libvirt}/bin/virsh start debian12
    '';
    serviceConfig = {
      Type = "oneshot";
      User = "root";
    };
  };
}
