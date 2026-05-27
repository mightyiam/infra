{ inputs, ... }:
{
  flake.modules.nixvim.base =
    { pkgs, ... }:
    {
      extraPlugins = [
        (pkgs.vimUtils.buildVimPlugin {
          pname = "autoreload-nvim";
          version = "0-unstable";
          src = inputs.autoreload-nvim;
        })
      ];
      extraConfigLua =
        # lua
        ''
          require('autoreload').setup({
            timer = {
              enabled = false
            }
          })
        '';
    };
}
