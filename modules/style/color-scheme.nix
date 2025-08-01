{ inputs, lib, ... }:
let
  polyModule.stylix = lib.mkDefault {
    base16Scheme = "${inputs.tinted-schemes}/base16/gruvbox-dark-medium.yaml";
    polarity = "dark";
  };
in
{
  flake.modules = {
    nixos.base = polyModule;
    homeManager.base = polyModule;
    nixOnDroid.base = polyModule;
    # https://github.com/danth/stylix/pull/415#issuecomment-2832398958
    #nixvim.astrea = polyModule;
  };
}
