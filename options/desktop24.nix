{
  hostName = "basilyes-desktop24";
  userName = "basilyes";
  name = "BasilYes";
  email = "basilyevs@gmail.com";
  hardwareFile = "desktop24.nix";
  nvidia = false;
  amd = true;
  gaming = true;
  develop = true;
  android = true;
  optionals = true;
  vm = true;
  forceWayland = true;
  hyprland = true;
  gnome = false;
  kde = false;
  network = true;
  # gdm or sddm
  displayManager = "gdm";
  nixVersion = "24.05";
}
