{ lib, ... }:
let
  inherit (lib) listToAttrs;

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
  programs = map mapper programs |> listToAttrs;
  services = map mapper services |> listToAttrs;
}
