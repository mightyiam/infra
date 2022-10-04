with builtins;
  instance: {pkgs, ...}: let
    pipe = pkgs.lib.trivial.pipe;
    programs = [
      "bat"
      "command-not-found"
      "direnv"
      "info"
    ];
    services = [
      "lorri"
      "systembus-notify"
    ];
    mapper = name: {
      name = "${name}";
      value = {enable = true;};
    };
  in {
    programs = pipe programs [(map mapper) listToAttrs];
    services = pipe services [(map mapper) listToAttrs];
  }
