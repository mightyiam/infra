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
  };
}
