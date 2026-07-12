{lib, ...}: {
  options.nixos.configurations = lib.mkOption {
    type = lib.types.lazyAttrsOf (
      lib.types.submodule (submoduleArgs: {
        # Make available outside of the NixOS config
        # for use of `system` in deriving of flake-parts `systems` list.
        options.facter.reportPath = lib.mkOption {
          type = lib.types.path;
        };
        config.module = {
          hardware.facter.report = submoduleArgs.config.facter.reportPath |> lib.readFile |> lib.fromJSON;
        };
      })
    );
  };
  config.nixos.modules.base = {pkgs, ...}: {
    environment.systemPackages = [pkgs.nixos-facter];
  };
}
