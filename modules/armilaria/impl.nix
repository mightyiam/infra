{
  inputs,
  config,
  lib,
  evalModulesModule,
  nixvim,
  withSystem,
  ...
}: {
  options.armilaria = lib.mkOption {
    type = lib.types.deferredModule;
  };

  config = {
    _module.args.nixvim =
      import "${inputs.nixvim}/lib/overlay.nix" |> lib.extend |> lib.getAttr "nixvim";

    users.mightyiam.home.base = hmArgs @ {pkgs, ...}: let
      cfg = hmArgs.config.armilaria;
    in {
      options.armilaria = lib.mkOption {
        type = lib.types.attrs;
        default = withSystem pkgs.stdenv.hostPlatform.system (
          psArgs:
            psArgs.config.armilaria.evaluation.extendModules {
              # https://github.com/danth/stylix/pull/415#issuecomment-2832398958
              modules = [hmArgs.config.stylix.targets.nixvim.exportedModule];
            }
        );
      };
      config.home = {
        packages = [cfg.config.build.package];
        sessionVariables.EDITOR = lib.getExe cfg.config.build.package;
      };
    };

    perSystem = psArgs @ {system, ...}: {
      options.armilaria = lib.mkOption {
        type = lib.types.submodule {
          imports = [
            evalModulesModule
            {
              fn = nixvim.evalNixvim;
              args = {inherit system;};
              module = config.armilaria;
            }
          ];
        };
      };

      config.packages.armilaria = psArgs.config.armilaria.evaluation.config.build.package;
    };
  };
}
