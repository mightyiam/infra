{
  inputs,
  lib,
  ...
}:
{
  flake.modules = {
    nixos.pc = {
      imports = [ inputs.stylix.nixosModules.stylix ];
      stylix = {
        enable = true;
        homeManagerIntegration.autoImport = false;
      };
    };

    homeManager.base = {
      imports = [ inputs.stylix.homeModules.stylix ];
      stylix.enable = true;
    };

    nixOnDroid.base = {
      imports = [ inputs.stylix.nixOnDroidModules.stylix ];
      stylix.enable = true;
    };

    nixvim.astrea = nixvimArgs: {
      # https://github.com/danth/stylix/pull/415#issuecomment-2832398958
      imports = lib.optional (nixvimArgs ? homeConfig) nixvimArgs.homeConfig.lib.stylix.nixvim.config;
    };
  };
}
