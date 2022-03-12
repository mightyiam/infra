with builtins;
  {
    config,
    lib,
    ...
  }: let
    pipe = lib.trivial.pipe;
    pubkeyAuthHosts = [
      "github.com"
      "gitlab.com"
      "gitlab.freedesktop.org"
      "teeveera.local"
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
      matchBlocks = pipe pubkeyAuthHosts [
        (map (host: {
          name = host;
          value = {
            extraOptions = {PubkeyAuthentication = "yes";};
            identityFile = toString config.home.homeDirectory + "/.ssh/id_${host}";
          };
        }))
        listToAttrs
      ];
    };
  }
