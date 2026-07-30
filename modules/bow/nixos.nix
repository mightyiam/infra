{mkModuleOption, ...}: {
  options.nixos.modules.bow = mkModuleOption {
    key = "bow";
  };
}
