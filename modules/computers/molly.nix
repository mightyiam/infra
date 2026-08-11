{
  config,
  lib,
  inputs,
  ...
}: {
  flake-file.inputs.pr-tracker = {
    url = "github:molybdenumsoftware/pr-tracker/v7.4.0";
    inputs = {
      flake-parts.follows = "flake-parts";
      nixpkgs.follows = "nixpkgs";
    };
  };

  nixos.configurations.molly = {
    module = nixosArgs: {
      imports =
        [
          config.nixos.modules.base
          inputs.pr-tracker.nixosModules.api
          inputs.pr-tracker.nixosModules.fetcher
        ]
        |> lib.concat [
          config.users.mightyiam.nixos.base
        ];

      boot.partlabels = ["disk-main-boot"];
      fileSystems."/" = {
        label = "disk-main-root";
        fsType = "ext4";
      };

      networking = {
        hostName = "nixpkgs";
        domain = "molybdenum.software";
        firewall.allowedTCPPorts = [80 443];
      };

      services = {
        pr-tracker = {
          db.createLocally = true;
          fetcher = {
            enable = true;
            branchPatterns = [
              "master"
              "staging"
              "staging-*"
              "nixos-*"
              "nixpkgs-unstable"
              "release-*"
            ];
            githubApiTokenFile = "/run/secrets/pr-tracker-github-token";
            repo = {
              owner = "NixOS";
              name = "nixpkgs";
            };
            onCalendar = "hourly";
          };
          api = {
            enable = true;
            port = 4242;
          };
        };
        caddy = {
          enable = true;
          virtualHosts.${nixosArgs.config.networking.fqdn}.extraConfig = ''
            reverse_proxy http://127.0.0.1:${toString nixosArgs.config.services.pr-tracker.api.port}
          '';
        };
      };

      systemd.services.pr-tracker-fetcher.environment.RUST_LOG = "info";
      system.stateVersion = "25.05";
    };

    facter.reportPath = ./molly.facter.json;
  };
}
