{
  self,
  lib,
  config,
  ...
}:
{
  config.programs.ssh.knownHosts =
    lib.filterAttrs (
      _name: config:
      !(lib.any isNull [
        config.config.networking.domain
        config.config.networking.hostname
        config.config.services.openssh.publicKey
      ])
    ) self.nixosConfigurations
    |> lib.mapAttrs (
      _name: config: {
        hostNames = [ config.config.networking.fqdn ];
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
