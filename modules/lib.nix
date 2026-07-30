{lib, ...}: {
  _module.args = {
    removeStorePathPrefix = path: path |> lib.splitString "/" |> lib.lists.drop 4 |> lib.concatStringsSep "/";

    mkModuleOption = args @ {
      key,
      static ? {},
      ...
    }:
      lib.mkOption {
        type = lib.types.deferredModuleWith {
          staticModules = [static];
        };

        ${
          if args ? default
          then "default"
          else null
        } =
          args.default;

        apply = module: {
          inherit key;
          imports = [module];
        };
      };
  };
}
