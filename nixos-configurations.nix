{
  lib,
  inputs,
  self,
  ...
}:
{
  imports = lib.pipe ./nixos-configurations [
    builtins.readDir
    lib.attrNames

    (map (hostname: {
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
    }))
  ];
}
