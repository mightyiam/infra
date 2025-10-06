{
  lib,
  config,
  inputs,
  ...
}:
{
  flake.modules.homeManager.base =
    hmArgs@{ pkgs, ... }:
    let
      # Ideally:
      #nixvim = self.packages.${pkgs.system}.nixvim;
      # but https://github.com/danth/stylix/pull/415#issuecomment-2832398958
      nixvim = inputs.nixvim.legacyPackages.${pkgs.system}.makeNixvimWithModule {
        inherit pkgs;
        extraSpecialArgs.homeConfig = hmArgs.config;
        module = config.flake.modules.nixvim.base;
      };
    in
    {
      home = {
        packages = [ nixvim ];
        sessionVariables.EDITOR = lib.getExe nixvim;
      };
    };
}
