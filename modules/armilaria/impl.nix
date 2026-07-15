{
  inputs,
  config,
  lib,
  nixvim,
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

    perSystem = {
      nixpkgs.overlays = [
        (final: prev: {
          armilaria =
            nixvim.evalNixvim {
              inherit (prev.stdenv.hostPlatform) system;
              modules = [
                {nixpkgs.pkgs = prev;}
                config.armilaria
              ];
            }
            |> (evaluation:
              evaluation.config.build.package
              // {
                inherit evaluation;
              });
        })
      ];
    };
  };
}
