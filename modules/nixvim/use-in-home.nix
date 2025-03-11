{
  lib,
  config,
  ...
}:
{
  flake.modules.homeManager.base =
    {
      pkgs,
      ...
    }:
    {
      home =
        let
          nixvim = config.flake.packages.${pkgs.stdenv.system}.nixvim;
        in
        {
          packages = [ nixvim ];
          sessionVariables.EDITOR = lib.getExe nixvim;
        };
    };
}
