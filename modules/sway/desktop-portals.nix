{
  flake.modules.homeManager.gui =
    { pkgs, ... }:
    {
      xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-wlr ];
    };
}
