{ inputs, ... }:
let
  polyModule.stylix = {
    base16Scheme = "${inputs.tinted-schemes}/base16/zenburn.yaml";
    polarity = "dark";
  };
in
{
  flake.modules = {
    nixos.wife = polyModule;
    homeManager.wife = polyModule;
  };
}
