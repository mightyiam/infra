{
  mkModuleOption,
  lib,
  inputs,
  ...
}: {
  options.nixos.modules.qmk = mkModuleOption {
    key = "qmk";
    static = {pkgs, ...}: {
      hardware.keyboard.qmk.enable = true;
      users.users.mightyiam.extraGroups = ["plugdev"];
      environment.systemPackages = [pkgs.vial];
    };
  };
  config = {
    flake-file.inputs.qmk-firmware = {
      url = "git+https://github.com/qmk/qmk_firmware.git?shallow=1&submodules=1";
      flake = false;
    };
    perSystem = {pkgs, ...}: {
      nixpkgs.overlays = [
        (final: prev: {
          filiformis-flash = final.callPackage ./filiformis/flash.pkg.nix {};
          filiformis-firmware = final.callPackage ./filiformis/firmware.pkg.nix {inherit (inputs) qmk-firmware;};
        })
      ];
      checks = ["filiformis-flash" "filiformis-firmware"] |> lib.flip lib.genAttrs (name: pkgs.${name});
    };
  };
}
