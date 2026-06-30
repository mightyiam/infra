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
          hardware.facter = {
            inherit (submoduleArgs.config.facter) reportPath;
          };
        };
      })
    );
  };
  config.nixos.modules.base = {pkgs, ...}: {
    hardware.facter.detected.dhcp.enable = false;
    environment.systemPackages = [pkgs.nixos-facter];
  };
}
