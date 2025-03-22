{ config
, pkgs
, pkgs-stable
, pkgs-unstable
, pkgs-extra
, lib
, extraOptions
, ...
}:

{
  services = {
    ollama = {
      enable = true;
      acceleration = "rocm";
      # package = pkgs-unstable.ollama-rocm;
      package = pkgs-extra.ollama-rocm;
      environmentVariables = {
        HCC_AMDGPU_TARGET = "gfx1101"; # used to be necessary, but doesn't seem to anymore
      };
      rocmOverrideGfx = "11.0.1";
      host = "0.0.0.0";
      port = 11434;
      openFirewall = true;
    };
    open-webui = {
      enable = true;
      # package = pkgs-extra.open-webui;
      host = "0.0.0.0";
      port = 8080;
      openFirewall = true;
    };
  };
}

