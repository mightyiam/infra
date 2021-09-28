{ config, ... }: {
  programs.ssh = {
    enable = true;
    compression = true;
    hashKnownHosts = false;
    extraConfig = ''
        IdentitiesOnly no
        PubkeyAuthentication no
    '';
    matchBlocks = {
      "github.com" = {
        extraOptions = {
          PubkeyAuthentication = "yes";
        };
        identityFile = builtins.toString config.home.homeDirectory + "/.ssh/id_github.com";
      };
      "gitlab.com" = {
        extraOptions = {
          PubkeyAuthentication = "yes";
        };
        identityFile = builtins.toString config.home.homeDirectory + "/.ssh/id_gitlab.com";
      };
      "gitlab.freedesktop.org" = {
        extraOptions = {
          PubkeyAuthentication = "yes";
        };
        identityFile = builtins.toString config.home.homeDirectory + "/.ssh/id_gitlab.freedesktop.org";
      };
    };
  };
}
