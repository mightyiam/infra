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
    perSystem = {
      nixpkgs.overlays = [
        (final: prev: {
          flash-lentinus = final.callPackage ./flash-lentinus.pkg.nix {};
        })
      ];
    };
  };
}
