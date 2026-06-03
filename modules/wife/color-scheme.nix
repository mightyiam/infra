{ inputs, ... }:
let
  polyModule.stylix = {
    base16Scheme = "${inputs.tinted-schemes}/base16/zenburn.yaml";
    polarity = "dark";
  };
in
{
  flake.modules = {
    nixos.bow = polyModule;
    homeManager.bow = polyModule;
  };
}
