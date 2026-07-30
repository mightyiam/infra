{mkModuleOption, ...}: {
  options.nixos.modules.base = mkModuleOption {
    key = "base";
  };
}
