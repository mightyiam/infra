{ lib, ... }:
{
  flake.modules.homeManager.base =
    { pkgs, ... }:
    let
      package = pkgs.dotool;
    in
    {
      options.dotoolc = lib.mkOption {
        type = lib.types.pathInStore;
        default = lib.getExe' package "dotoolc";
      };
      config = {
        home.packages = [ package ];
        wayland.windowManager.sway.extraConfig = "exec ${lib.getExe' package "dotoold"}";
      };
    };
}
