{
  inputs,
  nixvim,
  ...
}: {
  flake-file.inputs.autoreload-nvim = {
    flake = false;
    url = "github:ccntrq/autoreload.nvim";
  };

  perSystem = {
    nixpkgs.overlays = [
      (final: prev: {
        vimPlugins = prev.vimPlugins.extend (final': prev': {
          # TODO upstream
          auto-reload-nvim = prev.vimUtils.buildVimPlugin {
            pname = "autoreload-nvim";
            version = "0-unstable";
            src = inputs.autoreload-nvim;
          };
        });
      })
    ];
  };

  armilaria = {pkgs, ...}: {
    extraPlugins = [
      pkgs.vimPlugins.auto-reload-nvim
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
