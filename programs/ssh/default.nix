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
        identityFile = builtins.toString config.xdg.configHome + "/.ssh/id_github.com";
      };
    };
  };
}
