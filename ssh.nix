homeDirectory: {
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
      identityFile = builtins.toString homeDirectory + "/.ssh/id_github.com";
    };
  };
}
