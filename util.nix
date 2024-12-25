{ nixpkgs, ... }:
let
  inherit (nixpkgs) lib;
in
{
  readModulesDir =
    path:
    builtins.readDir path
    |> lib.filterAttrs (name: _: name != "default.nix")
    |> lib.mapAttrs' (name: type: lib.nameValuePair (lib.removeSuffix ".nix" name) (path + "/${name}"));
}
