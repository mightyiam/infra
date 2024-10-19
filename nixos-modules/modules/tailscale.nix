{
  config,
  pkgs,
  lib,
  ...
}:
{
  services.tailscale = {
    #enable = true;
  };
  systemd.services.sshd = lib.mkIf config.services.tailscale.enable {
    after = [ "tailscaled.service" ];
    serviceConfig.ExecStartPre = lib.getExe (
      pkgs.writeShellApplication {
        name = "wait-for-tailscale";
        runtimeInputs = [
          pkgs.gnugrep
          pkgs.tailscale
        ];
        text = ''
          until tailscale status | grep --quiet ${config.networking.hostName}
          do
            sleep 0.3
          done
        '';
      }
    );
  };
}
