{
  lib,
  config,
  inputs,
  ...
}:
let
  prefix = "nixOnDroidConfigurations/";
in
{
  flake = {
    nixOnDroidConfigurations =
      config.flake.modules.nixOnDroid or { }
      |> lib.filterAttrs (name: _module: lib.hasPrefix prefix name)
      |> lib.mapAttrs' (
        name: module:
        let
          droidName = lib.removePrefix prefix name;
        in
        {
          name = droidName;
          value = inputs.nix-on-droid.lib.nixOnDroidConfiguration {
            pkgs = import inputs.nixpkgs { system = "aarch64-linux"; };
            modules = [ module ];
          };
        }
      );

    checks =
      config.flake.nixOnDroidConfigurations
      |> lib.mapAttrsToList (
        name: nixOnDroid: {
          ${nixOnDroid.pkgs.stdenv.hostPlatform.system} = {
            "${prefix}${name}" = nixOnDroid.activationPackage;
          };
        }
      )
      |> lib.mkMerge;
  };
}
