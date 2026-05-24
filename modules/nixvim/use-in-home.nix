{
  lib,
  config,
  nixvim,
  ...
}:
{
  flake.modules.homeManager.base =
    hmArgs@{ pkgs, ... }:
    let
      # Ideally:
      #nixvim = self.packages.${pkgs.stdenv.hostPlatform.system}.nixvim;
      # but https://github.com/danth/stylix/pull/415#issuecomment-2832398958
      package =
        nixvim.evalNixvim {
          system = pkgs.stdenv.hostPlatform.system;
          extraSpecialArgs.homeConfig = hmArgs.config;
          modules = [ config.flake.modules.nixvim.base ];
        }
        |> (evaluation: evaluation.config.build.package);
    in
    {
      home = {
        packages = [ package ];
        sessionVariables.EDITOR = lib.getExe package;
      };
    };
}
