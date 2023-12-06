{ config, pkgs, ... }:

{
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