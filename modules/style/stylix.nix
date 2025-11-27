{
  inputs,
  lib,
  ...
}:
let
  polyModule = {
    stylix = {
      enable = true;
      enableReleaseChecks = false;
    };
  };
in
{
  flake.modules = {
    nixos.base = {
      imports = [
        inputs.stylix.nixosModules.stylix
        polyModule
      ];
      stylix.homeManagerIntegration.autoImport = false;
    };

    homeManager.base = {
      imports = [
        inputs.stylix.homeModules.stylix
        polyModule
      ];
    };

    nixOnDroid.base = {
      imports = [
        inputs.stylix.nixOnDroidModules.stylix
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
