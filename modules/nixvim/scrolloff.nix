{ inputs, ... }:
{
  flake.modules.nixvim.base =
    {
      pkgs,
      ...
    }:
    {
      extraPlugins = [
        (pkgs.vimUtils.buildVimPlugin {
          pname = "smart-scrolloff-nvim";
          version = "unstable";
          src = inputs.smart-scrolloff-nvim;
        })
      ];
      extraConfigLua = ''
        require('smart-scrolloff').setup({})
      '';
    };
}
