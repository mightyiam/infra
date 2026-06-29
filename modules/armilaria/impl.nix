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
    flake-file.inputs.nixvim = {
      url = "github:nix-community/nixvim";
      flake = false;
    };

    _module.args.nixvim =
      import "${inputs.nixvim}/lib/overlay.nix" |> lib.extend |> lib.getAttr "nixvim";

    users.mightyiam.home.base = hmArgs @ {pkgs, ...}: {
      options.armilaria = lib.mkOption {
        type = lib.types.attrs;
        default = pkgs.armilaria.evaluation.extendModules {
          # https://github.com/danth/stylix/pull/415#issuecomment-2832398958
          modules = [hmArgs.config.stylix.targets.nixvim.exportedModule];
        };
      };
      config.home = {
        packages = [hmArgs.config.armilaria.config.build.package];
        sessionVariables.EDITOR = lib.getExe hmArgs.config.armilaria.config.build.package;
      };
    };

    perSystem = {system, ...}: {
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
    };

    nixpkgs.overlays = [
      (final: prev: {
        armilaria = withSystem prev.stdenv.hostPlatform.system (psArgs:
          psArgs.config.armilaria.evaluation.config.build.package
          // {
            inherit (psArgs.config.armilaria) evaluation;
          });
      })
    ];
  };
}
