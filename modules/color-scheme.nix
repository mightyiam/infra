{ inputs, lib, ... }:
let
  polyModule.stylix = lib.mkDefault {
    base16Scheme = "${inputs.tinted-schemes}/base16/gruvbox-dark-medium.yaml";
    polarity = "dark";
  };
in
{
  flake.modules = {
    nixos.pc = polyModule;
    homeManager.base = {
      imports = [ polyModule ];

      # https://github.com/danth/stylix/issues/1183
      programs.qutebrowser.settings.colors.webpage.darkmode.enabled = false;
    };
    nixOnDroid.base = polyModule;
    # https://github.com/danth/stylix/pull/415#issuecomment-2832398958
    #nixvim.astrea = polyModule;
  };
}
