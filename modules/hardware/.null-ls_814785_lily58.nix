{mkModuleOption, ...}: {
  options.nixos.modules.lily58 = mkModuleOption {
    key = "lily58";
    static = {pkgs, ...}: {
      hardware.keyboard.qmk.enable = true;
      users.users.mightyiam.extraGroups = ["plugdev"];
      environment.systemPackages = [pkgs.flash-lily58 pkgs.vial];
    };
  };
  config = {
    flake-file.inputs.qmk-firmware = {
      url = "github:qmk/qmk_firmware";
      flake = false;
    };
    nixpkgs.overlays = [
      (final: prev: {
        flash-lily58 = prev.callPackage ./flash-lily58.nix {};
      })
    ];
  };
}
