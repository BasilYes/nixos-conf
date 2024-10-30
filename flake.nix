{
  description = "A simple NixOS flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.05";

    hyprpanel.url = "github:Jas-SinghFSU/HyprPanel";

    # stylix = {
    #   url = "github:bluskript/stylix";
    #   inputs = {
    #     nixpkgs.follows = "nixpkgs";
    #     home-manager.follows = "home-manager";
    #   };
    # };
  };

  outputs = inputs@{
    nixpkgs,
    home-manager,
    hyprpanel,
    ...
  }:let
    optionsList = map (n: "${./options}/${n}") (builtins.attrNames (builtins.readDir ./options));
  in
  {
    nixosConfigurations = builtins.listToAttrs (builtins.map(
      u:
      let
        options = import u;
      in
      {
        name = options.hostName;
        value = nixpkgs.lib.nixosSystem rec {
          system = "x86_64-linux";
          pkgs = import nixpkgs {
            inherit system;
            config.allowUnfree = true;
            overlays = [
              inputs.hyprpanel.overlay
            ];
          };
          specialArgs = {
            inherit inputs;
            extraOptions = options;
            pkgs-stable = import inputs.nixpkgs-stable {
              inherit system;
              config.allowUnfree = true;
            };
          };
          modules = [
            ./configuration.nix
            home-manager.nixosModules.home-manager {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.extraSpecialArgs = {
                extraOptions = options;
              };
              home-manager.users.${options.userName} = import ./home.nix;
            }
            # inputs.stylix.nixosModules.stylix
          ];
        };
      }
    ) optionsList);
  };
}
