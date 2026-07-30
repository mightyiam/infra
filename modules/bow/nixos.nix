{lib, ...}: {
  options.nixos.modules.bow = lib.mkOption {
    type = lib.types.deferredModule;
  };
}
