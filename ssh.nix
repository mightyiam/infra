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
      #identityFile = "/home/mightyiam/.ssh/id_github.com";
      #identityFile = "${"/home/mightyiam"}/.ssh/id_github.com";
      identityFile = builtins.toString homeDirectory + "/.ssh/id_github.com";
    };
  };
}
