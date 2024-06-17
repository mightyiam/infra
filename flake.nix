{
  outputs = {...}: {
    # Usage:
    # ```nix
    # {
    #   inputs.nixconfigs.url = "path:/home/mightyiam/src/nixconfigs";
    #   outputs = {
    #     nixpkgs,
    #     nixconfigs,
    #     ...
    #   }: let
    #     inherit (nixpkgs.lib) nixosSystem;
    #   in {
    #     nixosConfigurations.mightyiam-desktop = nixosSystem {
    #       modules = [nixconfigs.nixosModules.mightyiam-desktop];
    #     };
    #   };
    # }
    # ```
    nixosModules.mightyiam-desktop.imports = [./nixos-modules/hosts/mightyiam-desktop];
    # Usage:
    # ```nix
    # {
    #   inputs.catppuccin.url = "github:catppuccin/nix";
    #   inputs.nixconfigs.url = "path:/home/mightyiam/src/nixconfigs";
    #   inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    #   inputs.home-manager.url = "github:nix-community/home-manager";
    #   inputs.home-manager.inputs.nixpkgs.follows = "nixpkgs";
    #
    #   outputs = {
    #     nixconfigs,
    #     nixpkgs,
    #     home-manager,
    #     catppuccin,
    #     ...
    #   }: {
    #     homeConfigurations.mightyiam = home-manager.lib.homeManagerConfiguration {
    #       pkgs = nixpkgs.legacyPackages.x86_64-linux;
    #
    #       modules = [
    #         catppuccin.homeManagerModules.catppuccin
    #         nixconfigs.homeManagerModules.mightyiam
    #         {
    #           location.latitude = 18.746;
    #           location.longitude = 99.075;
    #         }
    #       ];
    #     };
    #   };
    # }
    # ```
    homeManagerModules.mightyiam.imports = [./home/home.nix];
  };
}
