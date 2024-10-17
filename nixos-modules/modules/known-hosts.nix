{
  self,
  lib,
  config,
  ...
}:
{
  config.programs.ssh.knownHosts =
    lib.filterAttrs (
      name: config: !isNull config.config.services.openssh.publicKey
    ) self.nixosConfigurations
    |> lib.mapAttrs (
      name: config: {
        hostNames = [ "*" ];
        inherit (config.config.services.openssh) publicKey;
      }
    );

  options.services.openssh.publicKey =
    lib.mkOption {
      type = lib.types.nullOr lib.types.str;
    }
    // lib.optionalAttrs (!config.services.openssh.enable) {
      default = null;
    };
}
