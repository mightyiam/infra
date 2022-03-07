with builtins; { config, ... }: {
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
        identityFile = toString config.home.homeDirectory + "/.ssh/id_github.com";
      };
      "gitlab.com" = {
        extraOptions = {
          PubkeyAuthentication = "yes";
        };
        identityFile = toString config.home.homeDirectory + "/.ssh/id_gitlab.com";
      };
      "gitlab.freedesktop.org" = {
        extraOptions = {
          PubkeyAuthentication = "yes";
        };
        identityFile = toString config.home.homeDirectory + "/.ssh/id_gitlab.freedesktop.org";
      };
      "192.168.1.60" = {
        extraOptions = {
          PubkeyAuthentication = "yes";
        };
        identityFile = toString config.home.homeDirectory + "/.ssh/id_teeveera";
      };
    };
  };
}
