{ config, pkgs, ... }:

let
  home-manager = builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/master.tar.gz";
in
{
  imports = [
    (import "${home-manager}/nixos")
  ];

  home-manager.users.basilyes = {
    
    home.stateVersion = "23.11";
    services.easyeffects.enable = true;
  };
  
  users.users.basilyes = {
    packages = with pkgs; [
    ];
  };

  environment.systemPackages = with pkgs; [
  ];

  programs.git = {
    enable = true;
    config = {
      init = {
        defaultBranch = "main";
      };
      user = {
        email = "basilyes@gmail.com";
        name = "BasilYes";
      };
      safe.directory = "/etc/nixos";
    };
  };
}
