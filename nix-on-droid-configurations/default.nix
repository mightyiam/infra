{
  self,
  inputs,
  lib,
  ...
}:
{
  imports =
    builtins.readDir ./.
    |> lib.filterAttrs (_: type: type == "directory")
    |> lib.mapAttrsToList (
      name: _: {
        flake.nixOnDroidConfigurations.${name} = inputs.nix-on-droid.lib.nixOnDroidConfiguration {
          pkgs = import inputs.nixpkgs { system = "aarch64-linux"; };
          extraSpecialArgs = {
            inherit self;
          };
          modules = [
            (./. + "/${name}")
          ];
        };
        #perSystem.checks."nixOnDroidConfigurations/lentinula" = self.nixOnDroidConfigurations.lentinula.activationPackage;
      }
    );
}
