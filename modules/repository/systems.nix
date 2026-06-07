{
  config,
  lib,
  ...
}: {
  systems =
    config.nixos.configurations
    |> lib.mapAttrsToList (name: {evaluation, ...}: evaluation.pkgs.stdenv.hostPlatform.system);
}
