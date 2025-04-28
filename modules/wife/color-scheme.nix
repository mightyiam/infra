{ config, inputs, ... }:
let
  polyModule.stylix = {
    base16Scheme = "${inputs.tinted-schemes}/base16/moonlight.yaml";
    polarity = "dark";
  };
in
{
  flake.modules = {
    nixos.wife = {
      imports = [ polyModule ];
      home-manager.users.${config.flake.meta.wife.username} = {
        imports = [
          inputs.stylix.homeManagerModules.stylix
          polyModule
        ];
      };
    };
  };
}
