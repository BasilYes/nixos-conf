{
  hostName = "basilyes-desktop";
  userName = "basilyes";
  name = "BasilYes";
  email = "basilyevs@gmail.com";
  hardwareFile = "desktop.nix";
  nvidia = true;
  gaming = true;
  develop = true;
  android = true;
  optionals = true;
  vm = true;
  forceWayland = true;
  hyprland = true;
  gnome = false;
  kde = false;
  # gdm or sddm
  displayManager = "gdm";
  nixVersion = "23.11";
}
