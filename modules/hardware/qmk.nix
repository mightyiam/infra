{mkModuleOption, ...}: {
  options.nixos.modules.qmk = mkModuleOption {
    key = "qmk";
    static = {pkgs, ...}: {
      hardware.keyboard.qmk.enable = true;
      users.users.mightyiam.extraGroups = ["plugdev"];
      environment.systemPackages = [pkgs.qmk pkgs.vial];
    };
  };
  config = {
    flake-file.inputs.qmk-firmware = {
      url = "github:qmk/qmk_firmware";
      flake = false;
    };
  };
}
