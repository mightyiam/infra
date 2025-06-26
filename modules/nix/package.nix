{ lib, ... }:
let
  getNix = pkgs: pkgs.nixVersions.nix_2_29;
in
{
  flake.modules = {
    nixos.pc =
      { pkgs, ... }:
      {
        nix.package = getNix pkgs;
      };

    homeManager.base =
      { pkgs, ... }:
      {
        nix.package = pkgs |> getNix |> lib.mkDefault;
      };

    nixOnDroid.base =
      { pkgs, ... }:
      {
        nix.package = getNix pkgs;
      };
  };
}
