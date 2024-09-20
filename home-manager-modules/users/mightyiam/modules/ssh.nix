{ config, ... }:
{
  programs.ssh = {
    enable = true;
    compression = true;
    hashKnownHosts = false;
    extraConfig = ''
      IdentitiesOnly no
      Include ${config.home.homeDirectory}/.ssh/hosts/*
    '';
  };
}
