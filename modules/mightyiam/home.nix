{
  lib,
  config,
  ...
}: {
  options.home = {
    base = lib.mkOption {
      type = lib.types.deferredModule;
    };
    gui = lib.mkOption {
      type = lib.types.deferredModule;
    };
  };
  config.users.mightyiam = {
    inherit (config) home;
  };
}
