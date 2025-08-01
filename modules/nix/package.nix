{ lib, ... }:
let
  polyModule =
    { pkgs, ... }:
    {
      nix.package =
        pkgs.nixVersions
        |> lib.attrNames
        |> lib.filter (lib.hasPrefix "nix_")
        |> lib.naturalSort
        |> lib.last
        |> lib.flip lib.getAttr pkgs.nixVersions
        |> lib.mkDefault;
    };
in
{
  flake.modules = {
    nixos.base = polyModule;
    homeManager.base = polyModule;
    nixOnDroid.base = polyModule;
  };
}
