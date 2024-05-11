{ config, pkgs, ... }:

let
  home-manager = builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/master.tar.gz";
in
{
  imports = [
    (import "${home-manager}/nixos")
  ];

  home-manager.users.basilyes = {
    programs.bash.enable = true;
    home.stateVersion = "23.11";
  };
  
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  

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
