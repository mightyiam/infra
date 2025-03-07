{ lib, ... }:
{
  flake.modules.homeManager.home =
    {
      pkgs,
      config,
      ...
    }:
    {
      home.packages = [ pkgs.bc ] ++ lib.optional config.gui.enable pkgs.qalculate-gtk;
    };
}
