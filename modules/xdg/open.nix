{ lib, ... }:
{
  flake.modules.homeManager.base =
    { pkgs, ... }:
    {
      programs.yazi.settings = {
        open.append_rules = [
          {
            mime = "*";
            use = "open";
          }
        ];
        opener.open = [
          {
            run = ''${lib.getExe' pkgs.xdg-utils "xdg-open"} "$@"'';
            desc = "Open";
          }
        ];
      };
    };
}
