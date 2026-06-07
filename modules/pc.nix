{config, ...}: {
  nixos.modules.pc = {
    imports = [
      config.nixos.modules.base
    ];
  };
}
