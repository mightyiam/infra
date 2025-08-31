{ config, ... }:
let
  inherit (config.flake.meta) repo;
in
{
  flake.modules.nixos.wife = {
    system.autoUpgrade = {
      enable = true;

      # Seems like this ends up being true by default, which is results in an error
      upgrade = false;

      flake = repo.flakeUri;
      operation = "boot";
    };
    programs.nh = {
      enable = true;
      clean = {
        enable = true;
        dates = "daily";
        extraArgs = "--keep 5";
      };
    };
  };
}
