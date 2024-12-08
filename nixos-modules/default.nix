{ lib, ... }:
{
  flake.nixosModules =
    builtins.readDir ./modules
    |> lib.mapAttrs' (
      name: type: lib.nameValuePair (lib.removeSuffix ".nix" name) (import ./modules + "/${name}")
    );
}
