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
    #     inherit (nixconfigs.nixosModules) mightyiam-desktop;
    #   in {
    #     nixosConfigurations.mightyiam-desktop = nixosSystem mightyiam-desktop;
    #   };
    # }
    # ```
    nixosModules.mightyiam-desktop.modules = [./nixos-modules/hosts/mightyiam-desktop];
  };
}
