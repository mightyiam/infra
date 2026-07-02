{
  lib,
  config,
  ...
}: {
  nixos.modules = {
    base = {
      options.services.openssh.publicKey = lib.mkOption {
        type = lib.types.nullOr lib.types.str;
        default = null;
      };

      config = {
        services.openssh = {
          enable = true;
          openFirewall = true;

          settings = {
            PasswordAuthentication = false;
          };

          extraConfig = ''
            Include /etc/ssh/sshd_config.d/*
          '';
        };

        programs.ssh.knownHosts =
          config.nixos.configurations
          |> lib.filterAttrs (
            _name: {evaluation, ...}:
              !(lib.any isNull [
                evaluation.config.networking.domain
                evaluation.config.networking.hostName
                evaluation.config.services.openssh.publicKey
              ])
          )
          |> lib.mapAttrs (
            _name: {evaluation, ...}: {
              hostNames = [evaluation.config.networking.fqdn];
              inherit (evaluation.config.services.openssh) publicKey;
            }
          );
      };
    };
  };
}
