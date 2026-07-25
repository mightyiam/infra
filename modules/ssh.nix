{
  lib,
  config,
  ...
}: {
  nixos.modules = {
    base = {
      options.services.openssh.publicKey = lib.mkOption {
        type = lib.types.nullOr lib.types.str;
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
          |> lib.filterAttrs (_name: {configuration, ...}: lib.isString configuration.config.services.openssh.publicKey)
          |> lib.mapAttrs (
            _name: {configuration, ...}: {
              hostNames = ["${configuration.config.networking.hostName}.local"];
              inherit (configuration.config.services.openssh) publicKey;
            }
          );
      };
    };
  };
}
