{
  config,
  lib,
  evalModulesModule,
  withSystem,
  ...
}: {
  options.nixos = {
    modules = lib.mkOption {
      type = lib.types.lazyAttrsOf lib.types.deferredModule;
    };

    configurations = lib.mkOption {
      type = lib.types.lazyAttrsOf (
        lib.types.submodule (
          {name, ...}: {
            imports = [evalModulesModule];
            fn = lib.nixosSystem;
            module = nixosArgs: {
              networking.hostName = lib.mkDefault name;
              nixpkgs.pkgs = withSystem nixosArgs.config.hardware.facter.report.system (lib.getAttr "pkgs");
            };
          }
        )
      );
    };
  };

  config = {
    flake = {
      nixosConfigurations = config.nixos.configurations |> lib.mapAttrs (name: {configuration, ...}: configuration);

      checks =
        config.nixos.configurations
        |> lib.mapAttrsToList (
          name: {configuration, ...}: {
            ${configuration.config.hardware.facter.report.system} = {
              "configurations:nixos:${name}" = configuration.config.system.build.toplevel;
            };
          }
        )
        |> lib.mkMerge;
    };
  };
}
