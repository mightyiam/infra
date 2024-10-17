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
    |> map (hostname: {
      flake =
        let
          nixosConfiguration = inputs.nixpkgs.lib.nixosSystem {
            specialArgs = {
              inherit self;
            };
            modules = [ (./nixos-configurations + "/${hostname}") ];
          };

          system = nixosConfiguration.config.nixpkgs.hostPlatform.system;
        in
        {
          nixosConfigurations.${hostname} = nixosConfiguration;
          checks.${system}."nixosConfigurations/${hostname}" =
            nixosConfiguration.config.system.build.toplevel;
        };
    });
}
