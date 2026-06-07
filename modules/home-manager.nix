{
  inputs,
  lib,
  ...
}: {
  options.homeManager = {
    modules = lib.mkOption {
      type = lib.types.lazyAttrsOf lib.types.deferredModule;
    };
  };

  config = {
    _module.args.homeManager = import "${inputs.home-manager}/lib" {inherit lib;};

    homeManager.modules.base = {
      programs.home-manager.enable = true;
    };
  };
}
