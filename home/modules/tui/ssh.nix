with builtins;
  instance: {
    config,
    lib,
    ...
  }: let
    keysPath = ~/.ssh/keys;

    keyFilenames =
      if builtins.pathExists keysPath
      then (lib.trivial.pipe keysPath [readDir attrNames])
      else [];

    isPublicKeyFilename = lib.strings.hasSuffix ".pub";

    pubkeyAuthHosts = lib.trivial.pipe keyFilenames [
      (builtins.filter (name: !(isPublicKeyFilename name)))
      (builtins.map (lib.strings.removePrefix "id_"))
    ];
  in {
    programs.ssh = {
      enable = true;
      compression = true;
      hashKnownHosts = false;
      extraConfig = ''
        IdentitiesOnly no
        PubkeyAuthentication no
      '';
      matchBlocks = lib.trivial.pipe pubkeyAuthHosts [
        (map (host: {
          name = host;
          value = {
            extraOptions = {PubkeyAuthentication = "yes";};
            identityFile = toString config.home.homeDirectory + "/.ssh/keys/id_${host}";
          };
        }))
        listToAttrs
      ];
    };
  }
