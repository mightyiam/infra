{
  home.base = hmArgs: {
    programs.ssh = {
      enable = true;
      enableDefaultConfig = false;
      includes = ["${hmArgs.config.home.homeDirectory}/.ssh/hosts/*"];
      settings."Host *" = {
        Compression = true;
        IdentitiesOnly = true;
        HashKnownHosts = false;
        IdentityFile = "${hmArgs.config.home.homeDirectory}/.ssh/id_ed25519";
      };
    };
  };

  nixos.modules.base = {
    users.users.mightyiam.openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICJVzohaJsHeG8sgtc1NiOIo3LVlEs4J1MMC0bV3CoyA"
    ];
  };
}
