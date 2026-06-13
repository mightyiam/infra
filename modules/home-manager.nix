{
  inputs,
  lib,
  ...
}: {
  options.homeManager = {
    modules = lib.mkOption {
      type = lib.types.lazyAttrsOf lib.types.deferredModule;
    };
  };

  config = {
    flake-file.inputs.home-manager = {
      url = "github:nix-community/home-manager";
      flake = false;
    };

    _module.args.homeManager = import "${inputs.home-manager}/lib" {inherit lib;};

    homeManager.modules.base = {
      programs.home-manager.enable = true;
    };

    nixos.modules.base = {pkgs, ...}: {
      home-manager.backupCommand = lib.getExe' pkgs.trash-cli "trash-put";
    };
  };
}
