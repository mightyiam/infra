{ lib, ... }:
let
  programs = [
    "command-not-found"
    "info"
  ];
  services = [ "systembus-notify" ];
  mapper = name: {
    name = "${name}";
    value = {
      enable = true;
    };
  };
in
{
  programs = map mapper programs |> lib.listToAttrs;
  services = map mapper services |> lib.listToAttrs;
}
