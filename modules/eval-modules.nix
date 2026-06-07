{lib, ...}: {
  _module.args.evalModulesModule = evalModulesArg: let
    cfg = evalModulesArg.config;
  in {
    options = {
      fn = lib.mkOption {
        type = lib.types.functionTo lib.types.attrs;
      };
      module = lib.mkOption {
        type = lib.types.deferredModule;
      };
      args = lib.mkOption {
        type = lib.types.lazyAttrsOf lib.types.anything;
      };
      evaluation = lib.mkOption {
        readOnly = true;
        type = lib.types.attrs;
        default = cfg.fn (
          cfg.args
          // {
            modules = [cfg.module];
          }
        );
      };
    };
  };
}
