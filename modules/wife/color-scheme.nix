{ config, inputs, ... }:
let
  polyModule.stylix = {
    base16Scheme = "${inputs.tinted-schemes}/base16/moonlight.yaml";
    polarity = "dark";
  };
in
{
  flake.modules = {
    nixos.wife = polyModule;
    homeManager.wife.imports = [
      inputs.stylix.homeManagerModules.stylix
      polyModule
    ];
  };
}
