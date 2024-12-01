{ config, lib, pkgs, ... }:

{
  hardware.graphics.enable = true;
	services.xserver.videoDrivers = [ "amdgpu" ];

	programs.corectrl.enable = true;
  environment.systemPackages = with pkgs; [
  ];
}
