{ lib, config, ... }:
{
  options.configurations.nixos = lib.mkOption {
    type = lib.types.lazyAttrsOf (
      lib.types.submodule {
        # TODO can this be not a list?
        options.modules = lib.mkOption {
          type = lib.types.listOf lib.types.deferredModule;
        };
      }
    );
  };

  config.flake.nixosConfigurations = lib.pipe config.configurations.nixos [
    (lib.mapAttrs (
      name: value:
      lib.nixosSystem {
        inherit (value) modules;
      }
    ))
  ];
}
