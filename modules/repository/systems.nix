{
  config,
  lib,
  ...
}: {
  systems =
    config.nixos.configurations
    |> lib.mapAttrsToList (name: {facter, ...}: facter.reportPath |> lib.readFile |> lib.fromJSON |> lib.getAttr "system");
}
