{
  description = "A simple NixOS flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    nixpkgs-extra.url = "github:nixos/nixpkgs/5df43628fdf08d642be8ba5b3625a6c70731c19c";

    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
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
    , rust-overlay
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
                inherit inputs rust-overlay;
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
                    extraOptions = options;
                  };
                  home-manager.users.${options.userName} = import ./home.nix;
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
