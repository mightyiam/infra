{
  config,
  lib,
  ...
}: {
  options.home = {
    base = lib.mkOption {
      type = lib.types.deferredModule;
      apply = module: {
        key = "base-alias";
        imports = [module];
      };
    };
    gui = lib.mkOption {
      type = lib.types.deferredModule;
      apply = module: {
        key = "gui-alias";
        imports = [module];
      };
    };
  };
  config.users.mightyiam = {
    inherit (config) home;
  };
}
