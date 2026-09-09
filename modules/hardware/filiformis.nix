{
  mkModuleOption,
  inputs,
  removeStorePathPrefix,
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
      url = "git+https://github.com/qmk/qmk_firmware.git?shallow=1&submodules=1";
      flake = false;
    };
    perSystem = {pkgs, ...}: {
      nixpkgs.overlays = [
        (final: prev: {
          filiformis-firmware = final.callPackage ./filiformis/firmware.pkg.nix {inherit (inputs) qmk-firmware;};
        })
      ];
      checks = {inherit (pkgs) filiformis-firmware;};
      treefmt.settings.global.excludes = [
        (__curPos.file
          |> removeStorePathPrefix
          |> lib.splitString "/"
          |> lib.lists.dropEnd 1
          |> lib.flip lib.concat ["filiformis" "layout.json"]
          |> lib.concatStringsSep "/")
      ];
    };
  };
}
