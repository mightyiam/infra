{
  mkModuleOption,
  config,
  ...
}: {
  options.nixos.modules.pc = mkModuleOption {
    key = "pc";
    static = config.nixos.modules.base;
  };
}
