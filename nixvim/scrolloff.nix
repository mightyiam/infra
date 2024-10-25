{
  self,
  pkgs,
  ...
}:
{
  extraPlugins = [
    (pkgs.vimUtils.buildVimPlugin {
      pname = "smart-scrolloff-nvim";
      version = "unstable";
      src = self.inputs.smart-scrolloff-nvim;
    })
  ];
  extraConfigLua = ''
    require('smart-scrolloff').setup({})
  '';
}
