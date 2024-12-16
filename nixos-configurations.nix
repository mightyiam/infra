{
  lib,
  inputs,
  self,
  ...
}:
{
  imports =
    builtins.readDir ./nixos-configurations
    |> lib.attrNames
    |> lib.filter (path: !(lib.hasPrefix "_" path))
    |> map (hostName: {
      flake =
        let
          nixosConfiguration = inputs.nixpkgs.lib.nixosSystem {
            specialArgs = {
              inherit self;
            };
            modules = [
              self.nixosModules.common
              (./nixos-configurations + "/${hostName}")
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
    });
}
