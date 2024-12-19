{ lib, config, ... }:
{
  options.me = lib.mkOption {
    type = lib.types.str;
    default = "mightyiam";
  };
  config.users.users.${config.me} = {
    isNormalUser = true;
    initialPassword = "";
    extraGroups = [
      "wheel"
      "audio"
      "docker"
      "input"
    ];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGPoHVrToSwWfz+DaUX68A9v70V7k3/REqGxiDqjLOS+"
    ];
  };
  config.nix.settings.trusted-users = [
    "root"
    config.me
  ];
}
