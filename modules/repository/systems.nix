{
  config,
  lib,
  ...
}: {
  systems =
    config.nixos.configurations
    |> lib.mapAttrsToList (name: {evaluation, ...}: evaluation.config.hardware.facter.report.system);
}
