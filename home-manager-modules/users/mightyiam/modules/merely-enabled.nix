{lib, ...}: let
  inherit
    (lib)
    listToAttrs
    pipe
    ;

  programs = [
    "command-not-found"
    "info"
  ];
  services = [
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
