{
  lib,
  config,
  ...
}:
let
  prefix = "nixosConfigurations/";
in
{
  flake = {
    nixosConfigurations =
      config.flake.modules.nixos or { }
      |> lib.filterAttrs (name: _module: lib.hasPrefix prefix name)
      |> lib.mapAttrs' (
        name: module:
        let
          hostName = lib.removePrefix prefix name;
        in
        {
          name = hostName;
          value = lib.nixosSystem {
            modules = [
              module
              { networking = { inherit hostName; }; }
            ];
          };
        }
      );
    checks =
      config.flake.nixosConfigurations
      |> lib.mapAttrsToList (
        name: nixos: {
          ${nixos.config.nixpkgs.hostPlatform.system} = {
            "${prefix}${name}" = nixos.config.system.build.toplevel;
          };
        }
      )
      |> lib.mkMerge;
  };
}
