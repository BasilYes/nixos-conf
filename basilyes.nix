{ config, pkgs, ... }:

let
  home-manager = builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/master.tar.gz";
in
{
  imports = [
    (import "${home-manager}/nixos")
  ];

  home-manager.users.basilyes = {
    home.packages = with pkgs; [
      neofetch
    ];
  
    services.easyeffects.enable = true;

    programs.home-manager.enable = true;
    programs.bash = {
      enable = true;
      bashrcExtra = ''
        eval "$(atuin init bash)"
        export EDITOR=vim'';
    };
    programs.git = {
      enable = true;
      userName = "BasilYes";
      userEmail = "basilyes@gmail.com";
      aliases = {
        la = "!git config -l | grep alias | cut -c 7-";
        cm = "commit -m";
        ca = "commit --amend";
        cam = "commit --amend -m";
        st = "status -sb";
        b = "!git for-each-ref --sort='-authordate' --format='%(authordate)%09%(objectname:short)%09%(refname)' refs/heads | sed -e 's-refs/heads/--'";
        lg1 = "log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(auto)%d%C(reset)' --all";
        lg2 = "log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold cyan)%aD%C(reset) %C(bold green)(%ar)%C(reset)%C(auto)%d%C(reset)%n''          %C(white)%s%C(reset) %C(dim white)- %an%C(reset)'";
        lg = "lg1";
      };
      extraConfig = {
        init = { defaultBranch = "main"; };
        safe = { directory = "/etc/nixos"; };
      };
    };
    
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
