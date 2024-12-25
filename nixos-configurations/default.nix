{
  lib,
  inputs,
  self,
  util,
  ...
}:
{
  imports =
    util.readModulesDir ./.
    |> lib.mapAttrsToList (
      hostName: path: {
        flake =
          let
            nixosConfiguration = inputs.nixpkgs.lib.nixosSystem {
              specialArgs = {
                inherit self;
              };
              modules = [
                self.nixosModules.common
                path
                {
                  networking = {
                    inherit hostName;
                  };
                }
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
    );
}
