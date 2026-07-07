{
  nixos.modules.pc = {
    specialisation.emulated-systems.configuration = {
      boot.binfmt.emulatedSystems = [
        "aarch64-linux"
        "riscv64-linux"
      ];
    };
  };
}
