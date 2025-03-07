{ config, ... }:
{
  flake.modules.nixos.wife = {
    system.autoUpgrade = {
      enable = true;
      flake = config.flake.meta.uri;
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
