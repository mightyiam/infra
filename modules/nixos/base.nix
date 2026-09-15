{lib, ...}: {
  options.nixos.modules.base = lib.mkOption {
    type = lib.types.deferredModule;
    apply = module: {
      key = "base";
      imports = [module];
    };
  };
}
