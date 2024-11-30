{
  description = "A simple NixOS flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.05";

    # nixpkgs-blender.url = "github:nixos/nixpkgs/18536bf04cd71abd345f9579158841376fdd0c5a";

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
          specialArgs = {
            inherit inputs;
            extraOptions = options;
            pkgs-stable = import inputs.nixpkgs-stable {
              inherit system;
              config.allowUnfree = true;
            };
            # pkgs-blender = import inputs.nixpkgs-blender {
            #   inherit system;
            # };
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
							home-manager.backupFileExtension = "backup";
            }
            # inputs.stylix.nixosModules.stylix
          ];
        };
      }
    ) optionsList);
  };
}
