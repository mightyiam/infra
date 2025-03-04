{
  lib,
  inputs,
  self,
  util,
  ...
}:
util.readModulesDir ./.
|> lib.mapAttrsToList (
  hostName: path: {
    flake =
      let
        nixosConfiguration = inputs.nixpkgs.lib.nixosSystem {
          specialArgs = { inherit self; };
          modules = [
            path
            { networking = { inherit hostName; }; }
          ];
        };

        system = nixosConfiguration.config.nixpkgs.hostPlatform.system;
      in
      {
        nixosConfigurations.${hostName} = nixosConfiguration;
        checks.${system}."nixosConfigurations/${hostName}" =
          nixosConfiguration.config.system.build.toplevel;
      };
  }
)
|> lib.mkMerge
