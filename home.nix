{ config, pkgs, extraOptions, ... }:

{
  imports = [
    ./theming.nix
  ];
  home.username = extraOptions.userName;
  home.homeDirectory = "/home/${extraOptions.userName}";

  home.packages = with pkgs; [
    #for nvim search
    fzf
    ripgrep
    wl-clipboard
    cargo
    # cinnamon.mint-cursor-themes
  ];

  dconf = {
    enable = true;
    settings."org/gnome/mutter/keybindings".switch-monitor = "['']";
  };

  # xdg.portal = {
  #   enable = true;
  #   extraPortals = [
  #     pkgs.xdg-desktop-portal-gtk # For both
  #   ];
  # };
  # services.easyeffects.enable = true;

  xdg.configFile.xdg-desktop-portal.source = ./.config/xdg-desktop-portal;
  # xdg.configFile.iamb.source = ./.config/iamb;
  # home.file.".config/xdg-desktop-portal/portals.conf".source = ./.config/xdg-desktop-portal/portals.conf;
  # xdg.configFile.nvim.source = ./nvim;
  # xdg.configFile.hypr.source = ./hypr;

  programs.home-manager.enable = true;
  programs.bash = {
    enable = true;
    bashrcExtra = ''
      eval "$(atuin init bash)"
      eval $(/run/wrappers/bin/gnome-keyring-daemon --start --components=ssh)
      export SSH_AUTH_SOCK
      export PS1="\n\[\033[1;32m\][\[\e]0;\u@\h: \w\a\]\u@\h:\W]\$\[\033[0m\]"
      '';
    shellAliases = {
      lg = "lazygit";
      ng = "nvim --listen /tmp/godot.pipe";
      c = "code .";
      z = "zeditor .";
      clean-and-switch = "sudo nix-collect-garbage -d && nix-collect-garbage -d && sudo nixos-rebuild switch";
    };
  };
  programs.neovim = {
    enable = true;
    vimAlias = true;
    viAlias = true;
    defaultEditor = true;
    withNodeJs = true;
  };
  programs.git = {
    enable = true;
    userName = extraOptions.name;
    userEmail = extraOptions.email;
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
      # credential.helper = "${
      #     pkgs.git.override { withLibsecret = true; }
      #   }/bin/git-credential-libsecret";
      init = { defaultBranch = "main"; };
      pull.rebase = true;
      commit.gpgsign = true;
    };
  };

  home.stateVersion = extraOptions.nixVersion;
}
