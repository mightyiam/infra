{
  lib,
  self,
  pkgs,
  ...
}:
{
  home =
    let
      nixvim = self.packages.${pkgs.stdenv.system}.nixvim;
    in
    {
      packages = [ nixvim ];
      sessionVariables.EDITOR = lib.getExe nixvim;
    };
}
