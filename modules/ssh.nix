{ lib, config, ... }:
let
  reachableNixoss =
    config.flake.nixosConfigurations
    |> lib.filterAttrs (
      _name: nixos:
      !(lib.any isNull [
        nixos.config.networking.domain
        nixos.config.networking.hostName
        nixos.config.services.openssh.publicKey
      ])
    );
in
{
  flake.modules = {
    nixos.base = {
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

        users.users.${config.flake.meta.owner.username}.openssh.authorizedKeys.keys = [
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGPoHVrToSwWfz+DaUX68A9v70V7k3/REqGxiDqjLOS+"
        ];

        programs.ssh.knownHosts =
          reachableNixoss
          |> lib.mapAttrs (
            _name: nixos: {
              hostNames = [ nixos.config.networking.fqdn ];
              inherit (nixos.config.services.openssh) publicKey;
            }
          );
      };
    };

    homeManager.base = args: {
      programs.ssh = {
        enable = true;
        compression = true;
        hashKnownHosts = false;
        includes = [ "${args.config.home.homeDirectory}/.ssh/hosts/*" ];
        matchBlocks =
          reachableNixoss
          |> lib.mapAttrsToList (
            _name: nixos: {
              "${nixos.config.networking.fqdn}" = {
                identityFile = "~/.ssh/keys/infra_ed25519";
              };
            }
          )
          |> lib.concat [
            {
              "*" = {
                setEnv.TERM = "xterm-256color";
                identitiesOnly = true;
              };
            }
          ]
          |> lib.mkMerge;
      };
    };
  };
}
