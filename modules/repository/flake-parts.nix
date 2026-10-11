{
  config,
  lib,
  ...
}: {
  flake-file.inputs.flake-parts.url = "github:hercules-ci/flake-parts";
  systems =
    config.nixos.configurations
    |> lib.mapAttrsToList (name: {facter, ...}: facter.reportPath |> lib.readFile |> lib.fromJSON |> lib.getAttr "system");
}
