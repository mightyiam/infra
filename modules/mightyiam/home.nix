{
  mkModuleOption,
  config,
  ...
}: {
  options.home = {
    base = mkModuleOption {
      key = "base-alias";
    };
    gui = mkModuleOption {
      key = "gui-alias";
    };
  };
  config.users.mightyiam = {
    inherit (config) home;
  };
}
