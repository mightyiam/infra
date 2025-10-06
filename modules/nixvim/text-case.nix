{
  flake.modules.nixvim.base =
    { pkgs, ... }:
    {
      extraPlugins = [ pkgs.vimPlugins.text-case-nvim ];
      extraConfigLua = ''
        require('textcase').setup {}
      '';
    };
}
