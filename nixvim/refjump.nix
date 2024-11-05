{ pkgs, self, ... }:
{
  extraPlugins = [
    (pkgs.vimUtils.buildVimPlugin {
      pname = "refjump-nvim";
      version = "unstable";
      src = self.inputs.refjump-nvim;
    })
  ];

  extraConfigLua = ''
    require('refjump').setup()
  '';
}
