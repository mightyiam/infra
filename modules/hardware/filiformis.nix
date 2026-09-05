{
  mkModuleOption,
  lib,
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
      url = "github:qmk/qmk_firmware";
      flake = false;
    };
    perSystem = {pkgs, ...}: {
      nixpkgs.overlays = [
        (final: prev: {
          filiformis-flash = final.callPackage ./flash.pkg.nix {};
          filiformis-firmware = final.callPackage ./firmware.pkg.nix {};
        })
      ];
      checks = ["filiformis-flash" "filiformis-firmware"] |> lib.flip lib.genAttrs (name: pkgs.${name});
    };
  };
}
