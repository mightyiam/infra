{
  inputs,
  lib,
  stylix,
  ...
}:
let
  polyModule = {
    stylix.enable = true;
  };
in
{
  _module.args.stylix = import inputs.stylix;

  flake.modules = {
    nixos.base = {
      imports = [
        stylix.nixosModules.stylix
        polyModule
      ];
      stylix.homeManagerIntegration.autoImport = false;
    };

    homeManager.base = {
      imports = [
        stylix.homeModules.stylix
        polyModule
      ];
    };

    nixOnDroid.base = {
      imports = [
        stylix.nixOnDroidModules.stylix
        polyModule
      ];
    };

    nixvim.base = nixvimArgs: {
      # https://github.com/danth/stylix/pull/415#issuecomment-2832398958
      imports = lib.optional (
        nixvimArgs ? homeConfig
      ) nixvimArgs.homeConfig.stylix.targets.nixvim.exportedModule;
    };
  };
}
