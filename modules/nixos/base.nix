{lib, ...}: {
  options.nixos.modules.base = lib.mkOption {
    type = lib.types.deferredModule;
  };
}
