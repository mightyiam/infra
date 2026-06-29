{
  config,
  lib,
  evalModulesModule,
  ...
}: let
  cfg = config.nixos;
in {
  options.nixos = {
    modules = lib.mkOption {
      type = lib.types.lazyAttrsOf lib.types.deferredModule;
    };

    configurations = lib.mkOption {
      type = lib.types.lazyAttrsOf (
        lib.types.submodule (
          {name, ...}: {
            imports = [
              evalModulesModule
              {
                fn = lib.nixosSystem;
                module = {
                  networking.hostName = lib.mkDefault name;
                };
              }
            ];
          }
        )
      );
    };
  };

  config.flake = {
    nixosConfigurations = cfg.configurations |> lib.mapAttrs (name: {evaluation, ...}: evaluation);

    checks =
      cfg.configurations
      |> lib.mapAttrsToList (
        name: {evaluation, ...}: {
          ${evaluation.config.hardware.facter.report.system} = {
            "configurations:nixos:${name}" = evaluation.config.system.build.toplevel;
          };
        }
      )
      |> lib.mkMerge;
  };
}
