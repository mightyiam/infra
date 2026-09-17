{inputs, ...}: {
  flake-file.inputs.pr-tracker = {
    url = "github:molybdenumsoftware/pr-tracker";
    flake = false;
  };

  perSystem = {
    nixpkgs.overlays = [(import "${inputs.pr-tracker}/nix/overlay.nix")];
  };

  nixos.configurations.molly = {
    module = nixosArgs: {
      imports = [
        "${inputs.pr-tracker}/nix/nixos/api"
        "${inputs.pr-tracker}/nix/nixos/fetcher"
      ];

      networking.firewall.allowedTCPPorts = [80 443];

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
            githubApiTokenFile = "/etc/credstore/pr-tracker-github-token";
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
    };
  };
}
