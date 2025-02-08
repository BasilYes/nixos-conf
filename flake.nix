{
  description = "A simple NixOS flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-extra.url = "github:nixos/nixpkgs/d0169965cf1ce1cd68e50a63eabff7c8b8959743";

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # hyprland = {
    #   type = "git";
    #   url = "https://github.com/hyprwm/Hyprland";
    #   submodules = true;
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
    # rust-overlay = {
    #   url = "github:oxalica/rust-overlay";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
    # stylix = {
    #   url = "github:bluskript/stylix";
    #   inputs = {
    #     nixpkgs.follows = "nixpkgs";
    #     home-manager.follows = "home-manager";
    #   };
    # };
  };

  outputs =
    inputs@{ nixpkgs
    , nixpkgs-extra
    , nixpkgs-unstable
    , nixpkgs-stable
    , home-manager
      # , rust-overlay
    , ...
    }:
    let
      optionsList = map (n: "${./options}/${n}") (builtins.attrNames (builtins.readDir ./options));
    in
    {
      nixosConfigurations = builtins.listToAttrs (builtins.map
        (
          u:
          let
            options = import u;
          in
          {
            name = options.hostName;
            value = nixpkgs.lib.nixosSystem rec {
              system = "x86_64-linux";
              specialArgs = {
                inherit inputs;
                # inherit inputs rust-overlay;
                extraOptions = options;
                pkgs-stable = import inputs.nixpkgs-stable {
                  inherit system;
                  config.allowUnfree = true;
                };
                pkgs-unstable = import inputs.nixpkgs-unstable {
                  inherit system;
                  config.allowUnfree = true;
                };
                pkgs-extra = import inputs.nixpkgs-extra {
                  inherit system;
                  config.allowUnfree = true;
                };
              };
              modules = [
                ./configuration.nix
                home-manager.nixosModules.home-manager
                {
                  home-manager.useGlobalPkgs = true;
                  home-manager.useUserPackages = true;
                  home-manager.extraSpecialArgs = {
                    inherit inputs;
                    extraOptions = options;
                  };
                  home-manager.users.${options.userName} = import ./home/home.nix;
                  home-manager.backupFileExtension = "backup";
                }
                # inputs.stylix.nixosModules.stylix
              ];
            };
          }
        )
        optionsList);
    };
}
