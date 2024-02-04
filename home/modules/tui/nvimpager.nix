instance: {
  pkgs,
  lib,
  ...
}: let
  inherit
    (lib)
    getExe
    ;
in {
  home.sessionVariables.PAGER = getExe pkgs.nvimpager;
}
