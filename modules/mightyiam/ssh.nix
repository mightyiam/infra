{
  home.base = hmArgs: {
    programs.ssh = {
      enable = true;
      enableDefaultConfig = false;
      includes = ["${hmArgs.config.home.homeDirectory}/.ssh/hosts/*"];
      settings."Host *" = {
        compression = true;
        identitiesOnly = true;
        hashKnownHosts = false;
        identityFile = "${hmArgs.config.home.homeDirectory}/.ssh/id_ed25519";
      };
    };
  };

  nixos.modules.base = {
    users.users.mightyiam.openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGPoHVrToSwWfz+DaUX68A9v70V7k3/REqGxiDqjLOS+"
    ];
  };
}
