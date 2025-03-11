{ lib, ... }:
{
  flake.modules.homeManager.base =
    {
      pkgs,
      config,
      ...
    }:
    {
      home.packages = [ pkgs.bc ] ++ lib.optional config.gui.enable pkgs.qalculate-gtk;
    };
}
