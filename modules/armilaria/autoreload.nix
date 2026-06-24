{
  inputs,
  nixvim,
  ...
}: {
  flake-file.inputs.autoreload-nvim = {
    flake = false;
    url = "github:ccntrq/autoreload.nvim";
  };

  armilaria = {pkgs, ...}: {
    extraPlugins = [
      # TODO upstream
      (pkgs.vimUtils.buildVimPlugin {
        pname = "autoreload-nvim";
        version = "0-unstable";
        src = inputs.autoreload-nvim;
      })
    ];
    extraConfigLua =
      # lua
      ''
        require('autoreload').setup(${nixvim.lua.toLuaObject {
          timer.enabled = false;
          conflict.strategy = "prompt";
        }})
      '';
  };
}
