{inputs, ...}: {
  armilaria = {pkgs, ...}: {
    extraPlugins = [
      # TODO upstream
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
