{ lib, inputs, ... }:
let
  settings = {
    keep-outputs = true;
    experimental-features = [
      "nix-command"
      "flakes"
      "pipe-operators"
      "recursive-nix"
    ];
    extra-system-features = [ "recursive-nix" ];
  };
in
{
  flake.modules = {
    nixos.desktop.nix = {
      inherit settings;
    };

    homeManager.base.nix = {
      inherit settings;
    };

    nixOnDroid.base.nix.extraOptions =
      settings |> lib.mapAttrsToList (name: value: "${name} = ${toString value}") |> lib.concatLines;
  };
}
