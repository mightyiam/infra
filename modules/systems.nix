{ config, lib, ... }:
{
  systems =
    config.flake.nixosConfigurations
    |> lib.mapAttrsToList (name: nixos: nixos.pkgs.stdenv.hostPlatform.system);
}
