{ config, pkgs, extraOptions, ... }:

{
	# systemd.timers."update_nix_system" = {
	# 	wantedBy = [ "timers.target" ];
	# 		timerConfig = {
	# 			OnCalendar = "daily";
	# 			Persistent = true; 
	# 			Unit = "update_nix_system.service";
	# 		};
	# };

	# systemd.services."update_nix_system" = {
	# 	script = ./scripts/update.sh;
	# 	serviceConfig = {
	# 		Type = "oneshot";
	# 		User = "root";
	# 	};
	# };
}
