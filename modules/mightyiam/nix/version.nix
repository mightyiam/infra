{lib, ...}: let
  polyModule = {pkgs, ...}: {
    nix.package =
      pkgs.nixVersions
      |> lib.attrNames
      |> lib.filter (lib.hasPrefix "nix_")
      |> lib.naturalSort
      |> lib.last
      |> lib.flip lib.getAttr pkgs.nixVersions
      |> lib.mkDefault;
  };
in {
  nixos.modules.base = polyModule;
  home.base = polyModule;
}
