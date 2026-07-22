{inputs, ...}: {
  flake-file.inputs.smart-scrolloff-nvim = {
    flake = false;
    url = "github:tonymajestro/smart-scrolloff.nvim";
  };

  perSystem = {
    nixpkgs.overlays = [
      (final: prev: {
        vimPlugins = prev.vimPlugins.extend (final': prev': {
          # TODO upstream
          smart-scrolloff-nvim = prev.vimUtils.buildVimPlugin {
            pname = "smart-scrolloff-nvim";
            version = "unstable";
            src = inputs.smart-scrolloff-nvim;
          };
        });
      })
    ];
  };

  armilaria = {pkgs, ...}: {
    extraPlugins = [
      pkgs.vimPlugins.smart-scrolloff-nvim
    ];
    extraConfigLua = ''
      require('smart-scrolloff').setup({})
    '';
  };
}
