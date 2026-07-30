{
  lib,
  config,
  ...
}: {
  options.nixos.modules.pc = lib.mkOption {
    type = lib.types.deferredModuleWith {
      staticModules = [config.nixos.modules.base];
    };
  };
}
