{ lib, ... }:
{
  flake.nixosModules =
    builtins.readDir ./.
    |> lib.filterAttrs (name: _: name != "default.nix")
    |> lib.mapAttrs' (name: type: lib.nameValuePair (lib.removeSuffix ".nix" name) (./. + "/${name}"));
}
