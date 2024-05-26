{ config, pkgs, ... }:

{

    home.username = "basilyes";
    home.homeDirectory = "/home/basilyes";

    home.packages = with pkgs; [
    ];
  
    services.easyeffects.enable = true;

    programs.home-manager.enable = true;
    programs.bash = {
      enable = true;
      bashrcExtra = ''
        eval "$(atuin init bash)"
        '';
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
  }