{ config, lib, pkgs, ... }:

{
  hardware.graphics.enable = true;
	hardware.graphics.enable32Bit = true;
	services.xserver.videoDrivers = [ "amdgpu" ];

	programs.corectrl.enable = true;
  environment.systemPackages = with pkgs; [
		vulkan-tools
		glxinfo
  ];
}
